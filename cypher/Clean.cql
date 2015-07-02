//Clean database of nodes and relationships
MATCH (n)
OPTIONAL MATCH (n)-[r]-()
DELETE n,r