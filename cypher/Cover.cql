CREATE  
(conference:Conference {name:"Conference"})-[:HOSTS]->(session:Session {name:"Session"}),
(developer:Person {name:"Developer"})-[:ATTENDS]->(session),
(session)-[:PROVIDES]->(skill:Skill {name:"Skill"}),
(developer)-[:LEARNS]->(skill)
RETURN *