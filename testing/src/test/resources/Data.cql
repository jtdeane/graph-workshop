//Initial Data Load
CREATE (Watergate:Organization {name:"Watergate Corporation"})
CREATE (Freshpond:Organization {name:"Freshpond LLC"})
CREATE (Thneed:Organization {name:"Thneed LLC"})

CREATE (Hospital:Location {name:"Hospital", description:"Watergate Hospital", type:"Facility"})
CREATE (Practice:Location {name:"Practice", description:"Watergate Physicians", type:"Professional"})
CREATE (IPAWest:Location {name:"IPA West", description:"Freshpond IPA West", type:"Professional"})
CREATE (IPAEast:Location {name:"IPA East", description:"Freshpond IPA East", type:"Professional"})
CREATE (HealthCenter:Location {name:"Health Center", description:"Thneed Health Center", type:"Professional"})

CREATE (Watergate)-[:MAINTAINS]->(Hospital),
(Watergate)-[:MAINTAINS]->(Practice),
(Freshpond)-[:MAINTAINS]->(IPAWest),
(Freshpond)-[:MAINTAINS]->(IPAEast),
(Thneed)-[:MAINTAINS]->(HealthCenter)

CREATE (Smith:Practitioner {name:"Zachary Smith", specialty:"General Medicine"})
CREATE (Zhivago:Practitioner {name:"Yuri Zhivago", specialty:"Immunology"})
CREATE (Moriarty:Practitioner {name:"James Moriarty", specialty:"Neurology"})
CREATE (McCoy:Practitioner {name:"Leonard McCoy", specialty:"General Medicine"})
CREATE (Geisel:Practitioner {name:"Theodor Geisel", specialty:"General Medicine"})

CREATE (Smith)-[:WORKS_FOR]->(Watergate),
(Smith)-[:WORKS_AT]->(Practice),
(Zhivago)-[:WORKS_FOR]->(Watergate),
(Zhivago)-[:WORKS_AT]->(Hospital),
(Zhivago)-[:WORKS_AT]->(Practice),
(Moriarty)-[:WORKS_FOR {owner:true}]->(Freshpond),
(Moriarty)-[:WORKS_AT]->(IPAWest),
(McCoy)-[:WORKS_FOR {owner:false}]->(Freshpond),
(McCoy)-[:WORKS_AT]->(IPAWest),
(McCoy)-[:WORKS_AT]->(IPAEast),
(Geisel)-[:WORKS_FOR {owner:true}]->(Thneed),
(Geisel)-[:WORKS_AT]->(HealthCenter)


CREATE (Tim:Patient {name:"Tim Smith", birth_date:"1965-06-27", conditions:["Diabetes", "Epilepsy"]})
CREATE (Jackie:Patient {name:"Jackie Bonk", birth_date:"1978-12-15"})
CREATE (Lovee:Patient {name:"Lovee Johnson", birth_date:"1982-01-18", conditions:["Diabetes", "Chronic Fatigue Syndrome"]})
CREATE (Yuri:Patient {name:"Yuri Zhivago", birth_date:"1959-02-05", conditions:["Diabetes"]})
CREATE (Holly:Patient {name:"Holly Goodwin", birth_date:"1991-11-17"})
CREATE (Michael:Patient {name:"Michael Moore", birth_date:"1963-04-21"})
CREATE (Inga:Patient {name:"Inga Yurel", birth_date:"1952-05-30", conditions:["Dementia"]})
CREATE (Max:Patient {name:"Max Cleveland ", birth_date:"1967-08-19", conditions:["Diabetes", "Chronic Fatigue Syndrome"]})

CREATE (Tim)-[:TREATED_BY {pcp:true}]->(Smith),
(Tim)-[:TREATED_BY {pcp:false}]->(Zhivago),
(Jackie)-[:TREATED_BY {pcp:true}]->(McCoy),
(Lovee)-[:TREATED_BY {pcp:true}]->(Geisel),
(Lovee)-[:TREATED_BY]->(Moriarty),
(Yuri)-[:TREATED_BY {pcp:true}]->(McCoy),
(Holly)-[:TREATED_BY]->(Geisel),
(Michael)-[:TREATED_BY {pcp:true}]->(Smith),
(Inga)-[:TREATED_BY {pcp:true}]->(Moriarty),
(Max)-[:TREATED_BY {pcp:true}]->(Geisel),
(Max)-[:TREATED_BY {pcp:false}]->(Moriarty)
