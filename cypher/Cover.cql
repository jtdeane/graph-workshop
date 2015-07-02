(UberConf:Conference)-[:HOSTS]->(session:Session)
(developer:Person)-[:ATTENDS]->(session)
(session)-[:PROVIDES]->(skill:Skill)
(developer)-[:LEARNS]->(skill)