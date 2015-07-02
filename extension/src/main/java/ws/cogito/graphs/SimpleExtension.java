package ws.cogito.graphs;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Result;
import org.neo4j.graphdb.Transaction;

@Path( "/directory" )
public class SimpleExtension {
	
    private final GraphDatabaseService graphDb;

    public SimpleExtension( @Context GraphDatabaseService database ) {
        
    	this.graphDb = database;    
    }

    @GET
    @Produces( MediaType.TEXT_PLAIN )
    @Path( "/practitioners" )
    public Response patients () {
    	
    	String practionerList = "Unavailable";
        
    	try (Transaction ignored = graphDb.beginTx();
    			Result result = graphDb.execute
    					( "MATCH (p:Practitioner) RETURN p AS Practitioners ORDER BY p.name" ))
    		{
    		practionerList = result.resultAsString();
    		}

        return Response.status( Status.OK ).entity(practionerList).build();
    }
}