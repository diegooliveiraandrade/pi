package pi.dao;

import java.io.File;
import java.net.URI;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.FileEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

public class AzureDAO {

	// key da API
	private static final String subscriptionKey = "ecf414eaa0434da2b46426317f6b999d";
	

	/**
	 * IDENTIFICANDO A PESSOA ATRAVES DO ID RECEBIDO PELO IdentifyCLiente
	 */
	public String identifyCliente(String idPhoto) {
		String retorno = null;
		String endPoint = "https://brazilsouth.api.cognitive.microsoft.com/face/v1.0/identify";
		HttpClient httpclient = new DefaultHttpClient();

		try {

			URIBuilder builder = new URIBuilder(endPoint);
			URI uri = builder.build();
			HttpPost request = new HttpPost(uri);
			request.setHeader("Content-Type", "application/json");
			request.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey);

			// Request body
			StringEntity reqEntity = new StringEntity("{\n" + "    \"personGroupId\": \"grupao\",\n"
					+ "    \"faceIds\": [\n" + "        \"" + idPhoto + "\"\n" + "    ],\n"
					+ "    \"maxNumOfCandidatesReturned\": 1,\n" + "    \"confidenceThreshold\": 0.5\n" + "}");
			request.setEntity(reqEntity);
			HttpResponse response = httpclient.execute(request);
			String json = EntityUtils.toString(response.getEntity());
			retorno = json;
			
			System.out.println("Identifica Cliente... cliente com estas caracteristicas:" + "\n" + json);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return retorno;

	}

	/*
	 * TREINANDO A API PARA MAIOR ACURACIDADE
	 */
	public void training() {
		String endPoint = "https://brazilsouth.api.cognitive.microsoft.com/face/v1.0/persongroups/grupao/train";
		HttpClient httpclient = new DefaultHttpClient();
		try {

			URIBuilder builder = new URIBuilder(endPoint);
			URI uri = builder.build();
			HttpPost request = new HttpPost(uri);
			request.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey);

			// Request body
			StringEntity reqEntity = new StringEntity("{ }");
			request.setEntity(reqEntity);
			HttpResponse response = httpclient.execute(request);
			HttpEntity entity = response.getEntity();

			if (entity != null) {
				System.out.println(EntityUtils.toString(entity));
				System.out.println("Training...");
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
	}

	/*
	 * DETECTANDO ATRAVES DE UMA URL
	 */
	public String detectClienteToUrl(String linkToFoto) {
		String retorno = null;
		String endPointDetect = "https://brazilsouth.api.cognitive.microsoft.com/face/v1.0/detect";

		String imageWithFaces = linkToFoto;
		HttpClient httpclient = new DefaultHttpClient();
		try {

			URIBuilder builder = new URIBuilder(endPointDetect);

			// Request parameters. All of them are optional.
			builder.setParameter("returnFaceId", "true");
			builder.setParameter("returnGender", "false");
			builder.setParameter("returnFaceLandmarks", "false");

			// builder.setParameter("returnFaceAttributes", faceAttributesDetect);
			// Prepare the URI for the REST API call.
			URI uri = builder.build();
			HttpPost request = new HttpPost(uri);

			// Request headers.
			request.setHeader("Content-Type", "application/json");
			request.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey);

			// Request body.
			StringEntity reqEntity = new StringEntity(imageWithFaces);
			request.setEntity(reqEntity);

			// Execute the REST API call and get the response entity.
			HttpResponse response = httpclient.execute(request);
			HttpEntity entity = response.getEntity();
			String json = EntityUtils.toString(response.getEntity());
			json = json.replace("[", "");
			if (entity != null) {

				// catch the faceID
				JSONObject teste = new JSONObject(json);
				retorno = teste.getString("faceId");
				System.out.println("FaceID da pessoa: " + retorno);

			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return retorno;
	}

	/*
	 * INSER��O DE UMA FOTO SALVA
	 */
	public void insertPhotoClienteLocal(String personId, String user, String photoUrl) {
		String endPoint = "https://brazilsouth.api.cognitive.microsoft.com/face/v1.0/persongroups/grupao/persons/"
				+ personId + "/persistedFaces";
		HttpClient httpclient = new DefaultHttpClient();
		try {

			URIBuilder builder = new URIBuilder(endPoint);
			URI uri = builder.build();
			HttpPost request = new HttpPost(uri);
			request.setHeader("Content-Type", "application/octet-stream");
			request.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey);
			builder.setParameter("userData", "{" + user + "}");
			builder.setParameter("targetFace", "");

			// Request body
			File file = new File(photoUrl);
			FileEntity reqEntity = new FileEntity(file, ContentType.APPLICATION_OCTET_STREAM);
			request.setEntity(reqEntity);
			HttpResponse response = httpclient.execute(request);
			HttpEntity entity = response.getEntity();
			System.out.println(response.getStatusLine());

			if (entity != null) {
				System.out.println(EntityUtils.toString(entity));
				System.out.println("Foto :" + photoUrl + " do cliente inserida no Azure!");
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

	}

	/*
	 * INSER��O DA FOTO ATRAVES DE UM ARQUIVO .PNG
	 */
	public void insertPhotoClienteFile(String personId, String user, File file) {
		String endPoint = "https://brazilsouth.api.cognitive.microsoft.com/face/v1.0/persongroups/grupao/persons/"
				+ personId + "/persistedFaces";
		HttpClient httpclient = new DefaultHttpClient();
		try {

			URIBuilder builder = new URIBuilder(endPoint);
			URI uri = builder.build();
			HttpPost request = new HttpPost(uri);
			request.setHeader("Content-Type", "application/octet-stream");
			request.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey);
			builder.setParameter("userData", "{" + user + "}");
			builder.setParameter("targetFace", "");

			// Request body
			FileEntity reqEntity = new FileEntity(file, ContentType.APPLICATION_OCTET_STREAM);
			request.setEntity(reqEntity);
			HttpResponse response = httpclient.execute(request);
			HttpEntity entity = response.getEntity();
			System.out.println(response.getStatusLine());
			if (entity != null) {
				System.out.println(EntityUtils.toString(entity));
				System.out.println("Foto :" + file.getName() + " do cliente inserida no Azure!");
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

	}

	/**
	 * DETECTANDO O CLIENTE ATRAVES DE UMA STRING
	 */
	public String detectCliente(String urlPhoto) {
		String endPointDetect = "https://brazilsouth.api.cognitive.microsoft.com/face/v1.0/detect";
		String idPhoto = "";
		HttpClient httpclient = new DefaultHttpClient();

		try {
			URIBuilder builder = new URIBuilder(endPointDetect);

			// Request parameters. All of them are optional.
			builder.setParameter("returnFaceId", "true");
			builder.setParameter("returnFaceLandmarks", "false");

			// Prepare the URI for the REST API call.
			URI uri = builder.build();
			HttpPost request = new HttpPost(uri);

			// Request headers.
			request.setHeader("Content-Type", "application/octet-stream");
			request.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey);

			// Request body.
			File file = new File(urlPhoto);
			FileEntity reqEntity = new FileEntity(file, ContentType.APPLICATION_OCTET_STREAM);
			request.setEntity(reqEntity);

			// Execute the REST API call and get the response entity.
			HttpResponse response = httpclient.execute(request);
			HttpEntity entity = response.getEntity();
			String json = EntityUtils.toString(response.getEntity());
			json = json.replace("[", "");

			// response
			if (entity != null) {
				JSONObject teste = new JSONObject(json);
				idPhoto = teste.getString("faceId");
				System.out.println("Rodando detectCliente() \nId da foto: " + idPhoto
						+ "\n.........................................................................\n");
			}

		} catch (Exception e) {

			System.out.println(e.getMessage());
		}

		return idPhoto;
	}

	/*
	 * DETECTANDO ATRAVES DE UM ARQUIVO (file)
	 */

	public String detectClienteFile(File file) {
		String endPointDetect = "https://brazilsouth.api.cognitive.microsoft.com/face/v1.0/detect";
		String idPhoto = "";
		HttpClient httpclient = new DefaultHttpClient();

		try {

			URIBuilder builder = new URIBuilder(endPointDetect);

			// Request parameters. All of them are optional.
			builder.setParameter("returnFaceId", "true");

			builder.setParameter("returnFaceLandmarks", "false");

			// Prepare the URI for the REST API call.
			URI uri = builder.build();
			HttpPost request = new HttpPost(uri);

			// Request headers.
			request.setHeader("Content-Type", "application/octet-stream");
			request.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey);

			// Request body.
			FileEntity reqEntity = new FileEntity(file, ContentType.APPLICATION_OCTET_STREAM);
			request.setEntity(reqEntity);

			// Execute the REST API call and get the response entity.
			HttpResponse response = httpclient.execute(request);
			HttpEntity entity = response.getEntity();
			String json = EntityUtils.toString(response.getEntity());
			json = json.replace("[", "");

			// response
			if (entity != null) {
				JSONObject teste = new JSONObject(json);
				idPhoto = teste.getString("faceId");
				System.out.println("Rodando detectCliente() \nId da foto: " + idPhoto
						+ "\n.........................................................\n");
				System.out.println(entity.toString());
			}
		} catch (Exception e) {

			System.out.println(e.getMessage());
		}
		return idPhoto;
	}

	/*
	 * INSERINDO UMA PESSOA EM UM GRUPO DO AZURE
	 */
	public String insertCliente(String nome, String user) {
		String endPoint = "https://brazilsouth.api.cognitive.microsoft.com/face/v1.0/persongroups/grupao/persons";
		String personId = "";
		HttpClient httpclient = new DefaultHttpClient();

		try {

			URIBuilder builder = new URIBuilder(endPoint);
			URI uri = builder.build();

			// Request header
			HttpPost request = new HttpPost(uri);
			request.setHeader("Content-Type", "application/json");
			request.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey);

			// Request body
			StringEntity reqEntity = new StringEntity("{\r\n" + "    \"name\": \"" + nome + "\",\r\n"
					+ "    \"userData\": \"" + user + "\"\r\n" + "}\r\n" + "");
			request.setEntity(reqEntity);

			// Response
			HttpResponse response = httpclient.execute(request);
			HttpEntity entity = response.getEntity();
			String json = EntityUtils.toString(response.getEntity());

			// response
			if (entity != null) {
				final ObjectNode node = new ObjectMapper().readValue(json, ObjectNode.class);
				if (node.has("personId")) {
					personId = node.get("personId").toString();
					personId = personId.replaceAll("\"", "");
				}
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return personId;
	}

}
