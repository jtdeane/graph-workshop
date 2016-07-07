//Aggregate all providers
MATCH (c:Caregiver) RETURN c.name AS names UNION MATCH (p:Practitioner) RETURN p.name AS names

//Practitioners with patient counts
MATCH (m:Patient) -[:TREATED_BY]-> (p:Practitioner) WITH p, COUNT(m) AS patients RETURN p.name, patients

//Patients with provider counts (Practitioner and/or Care Giver)
MATCH (m:Patient) -[:TREATED_BY|:CARES_FOR]- (r) WITH DISTINCT (m), COUNT(r) AS providers RETURN m.name, providers

//All Patients with Caregiver (and without = null)
MATCH (m:Patient) OPTIONAL MATCH (m) <-[:CARES_FOR]- (c:Caregiver) RETURN m.name, COALESCE(c.name,"INDEPENDENT")

//Profile simple query
PROFILE MATCH (p) WHERE p.name="Zachary Smith" RETURN p

//Profile updated simple query
PROFILE MATCH (p:Practitioner) WHERE p.name="Zachary Smith" RETURN p

//Profile complex query
PROFILE MATCH (m:Patient), (p:Practitioner) WHERE m.name=p.name RETURN p

//Call a Procedure
CALL db.labels()

//List available Procedures
CALL dbms.procedures()

//Delete a node and any relationships to and from it
MATCH (n { name:'Florence Nightingale' }) DETACH
DELETE n