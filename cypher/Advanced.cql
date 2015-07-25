//load caregiver nodes
LOAD CSV WITH HEADERS FROM "file:///Users/jeremydeane/CaregiverNodes.csv" AS csvLine
CREATE (g:Caregiver {name: csvLine.name, guardian: csvLine.guardian}) RETURN *

//load caregiver patient relationships
LOAD CSV WITH HEADERS FROM "file:///Users/jeremydeane/PatientRelationships.csv" AS csvLine
MATCH (giver:Caregiver { name:(csvLine.giver)}), (patient:Patient { name:(csvLine.patient)}) 
CREATE (giver)-[:CARES_FOR { type:(csvLine.type) }]->(patient) RETURN *

//load caregiver organization relationships
LOAD CSV WITH HEADERS FROM "file:///Users/jeremydeane/OrganizationRelationships.csv" AS csvLine
MATCH (giver:Caregiver { name:(csvLine.giver)}), (org:Organization { name:(csvLine.organization)}) 
CREATE (giver)-[:WORKS_FOR { type:(csvLine.status) }]->(org) RETURN *

//Return the patients with a family cargiver and their practitioners
MATCH (g:Caregiver)-[CARES_FOR {type:"Family"}]->(m:Patient)-[TREATED_BY]->(p:Practitioner) RETURN m, p, g

//Find patients who are also a practitioners
MATCH (m:Patient), (p:Practitioner) WHERE m.name=p.name RETURN p

//All patients with a PCP having a name ending in y (REGEX)
MATCH (m:Patient)-[TREATED_BY {pcp:true}]->(p:Practitioner) WHERE p.name=~ ".*y" RETURN m,p

//All paths to Lovee Johnson
MATCH paths = (m:Patient)-[*]-(node) WHERE m.name="Lovee Johnson" RETURN paths

//Shortest path from Lovee Jonhnson to Florence Nightingale 
MATCH (m:Patient {name:"Lovee Johnson"}), 
(g:Caregiver {name:"Florence Nightingale"}), 
path = shortestPath((m)-[*..10]-(g)) RETURN path

//Patients with more than one practitioner
MATCH (patient:Patient)-[:TREATED_BY]->(practitioner)
WITH patient, count (practitioner) AS practitioners
WHERE practitioners > 1
RETURN patient

//create index on Patient Label
CREATE INDEX ON :Patient(name)

//GET http://localhost:7474/db/data/schema/index/Patient

//drop index on Patient Label
DROP INDEX ON :Patient(name)

//From previous Server Extension may need to drop constrain on Practitioner
DROP INDEX ON :Practitioner(name)

//create Unique Practitioner constraint
CREATE CONSTRAINT ON (practitioner:Practitioner) ASSERT practitioner.name IS UNIQUE

//GET http://localhost:7474/db/data/schema/constraint/Practitioner

//attempt to create duplicate Practitioner - should fail
CREATE (McCoy:Practitioner {name:"Leonard McCoy", specialty:"General Medicine"})

//drop Unique Practitioner constraint
DROP CONSTRAINT ON (practitioner:Practitioner) ASSERT practitioner.name IS UNIQUE