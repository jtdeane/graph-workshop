package ws.cogito.graphs;

import static org.junit.Assert.assertEquals;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Result;
import org.neo4j.graphdb.Transaction;
import org.neo4j.kernel.impl.core.NodeProxy;
import org.neo4j.test.TestGraphDatabaseFactory;

public class SimpleGraphTest {

	GraphDatabaseService graphDb;

	@Before
	public void prepareTestDatabase()
	{
		graphDb = new TestGraphDatabaseFactory().newImpermanentDatabase();
		
		//populate database
		graphDb.execute(getCypher());
	}
	
	@After
	public void destroyTestDatabase()
	{
	    graphDb.shutdown();
	}

    @Test
    public void example1() throws Exception
    {
        
    	try ( Transaction tx = graphDb.beginTx() )
    	{
    	    
    		String cypher = "MATCH (a)-[:MAINTAINS]->(b) RETURN COUNT(DISTINCT a) as Total";
    		
    		Result result = graphDb.execute (cypher);
    		
    		Map<String, Object> row = result.next();
    		
    		Long total = (Long) row.get("Total");
    		
    		assertEquals (total.intValue(), 3);
    		
    		//comment out 49-53 before uncommenting below
    		//System.out.println("Result: " + result.resultAsString());
    	}
    }
    
    @Test
    public void example2() throws Exception
    {
        
    	try ( Transaction tx = graphDb.beginTx() )
    	{
    	    
    		String cypher = "MATCH (p:Practitioner) WHERE p.name={name} RETURN p";
    		
    		Map <String, Object> parameters = new HashMap <String, Object>();
    		
    		parameters.put("name", "Zachary Smith");
    		
    		Result result = graphDb.execute (cypher, parameters);
    		
    		Map<String, Object> row = result.next();
    		
    		NodeProxy Nodeproxy = (NodeProxy) row.get("p");
    		
    		String specialty = (String) Nodeproxy.getProperty("specialty");
    		
    		assertEquals (specialty, "General Medicine");
    		
    		//comment out 75-81 before uncommenting below
    		//System.out.println("Result: " + result.resultAsString());
    	}
    }
    
    private String getCypher () {
    	
    	String cypher = null;
		
		try {
			
			cypher = IOUtils.toString(this.getClass().getClassLoader()
			        .getResourceAsStream("Data.cql"));
			
			System.out.println(cypher);
		
		} catch (IOException e) {
			
			throw new RuntimeException(e.getMessage());
		}
		
		return cypher;
    }
}