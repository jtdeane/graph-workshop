//Retrieve a Node with Label Practitioner with a property equal to Zachary Smith 
MATCH (p:Practitioner) WHERE p.name="Zachary Smith" RETURN p

//Retrieve all Nodes with Label Organization 
MATCH (o:Organization) RETURN o ORDER BY o.name DESC

//Retrieve all Nodes with Label Patient 
MATCH (m:Patient) RETURN upper(m.name), m.birth_date ORDER BY m.birth_date

//Retrieve all Nodes with Label Patient and with diabetes
MATCH (m:Patient) WHERE "Diabetes" IN m.conditions RETURN m

//Retrieve all Nodes with Label Patient and without diabetes
MATCH (m:Patient) WHERE NOT("Diabetes" IN m.conditions) RETURN m

//Retrieve all Nodes with WORKS_AT Relationship
MATCH (a)-[r:WORKS_AT]->(b) RETURN a,r,b

//Retrieve all Nodes with TREATED_BY Relationship with PCP false
MATCH (a)-[r:TREATED_BY {pcp:false}]->(b) RETURN a,r,b

//Retrieve all distinct list of Nodes that MAINTAIN a Node
MATCH (a)-[:MAINTAINS]->(b) RETURN COUNT(DISTINCT a)