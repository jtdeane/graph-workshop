//Create Node
CREATE (:Practitioner {name:"Zachary Smith", specialty:"General Medicine"})

//	 Node
MATCH (p:Practitioner) RETURN p

//Update Node
MATCH (p) WHERE p.name="Zachary Smith" SET p.specialty="Neurosurgery"

//Retrieve Updated Node
MATCH (p:Practitioner) WHERE p.specialty="Neurosurgery" RETURN p.name, p.specialty

//Retrieve Node by ID - may need to update ID
MATCH (p) WHERE ID(p)=0 RETURN p

//Delete Node By ID - may need to update ID
MATCH (p) WHERE ID(p)=0 DELETE p

//Merge Node
MERGE (p:Practitioner {name:"Zachary Smith"})
ON CREATE SET n.created=timestamp()
ON MATCH SET n.updated=timestamp()

//Create Node
CREATE (:Patient {name:"Tim Smith", birth_date:"1965-06-27", conditions:["Diabetes", "Epilepsy"]})

//Create Relationship Long - Requires Patient Tim Smith and Practitioner Zachary Smith
MATCH  (p:Practitioner {name:"Zachary Smith"})
MATCH  (m:Patient {name:"Tim Smith"})
CREATE (m)-[r:TREATED_BY]->(p)
RETURN m, r, p

//Create Relationship Medium - Requires Practitioner Zachary Smith
MATCH  (p:Practitioner {name:"Zachary Smith"})
CREATE (m:Patient {name:"Holly Goodwin", birth_date:"1991-11-17"})-[r:TREATED_BY]->(p)
RETURN m, r, p

//Create Nodes and Relationship Short
CREATE (m:Patient {name:"Jackie Bonk", birth_date:"1978-12-15"})-[r:TREATED_BY]->(p:Practitioner {name:"Yuri Zhivago", specialty:"Immunology"})
RETURN m, r, p

//Clean out Nodes and Relationships
MATCH (n)
OPTIONAL MATCH (n)-[r]-()
DELETE n,r