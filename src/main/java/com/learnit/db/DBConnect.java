package com.learnit.db;

import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.DeleteResult;
import com.mongodb.client.result.UpdateResult;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import org.bson.types.ObjectId;
import java.util.ArrayList;

import java.util.List;

import javax.swing.text.AbstractDocument.LeafElement;

import org.bson.Document;
import org.bson.conversions.Bson;

public class DBConnect {
	// Create a method to insert data into the database
	public void sReg(String firstName, String lastName, String email, String password, String retypedPassword) {
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			MongoClient mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("User_Info");

			// Create a document with all the form data
			Document document = new Document("FirstName", firstName).append("LastName", lastName).append("Email", email)
					.append("Password", password).append("RetypedPassword", retypedPassword);

			// Insert the document
			collection.insertOne(document);

			// Close the MongoClient when done
			mongoClient.close();
		} catch (Exception e) {
			System.out.println("Error occurred: " + e);
		}
	}

	public void TReg(String firstName, String lastName, String email, String qualification, String password,
			String retypedPassword) {
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			MongoClient mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Instructor_Info");

			// Create a document with all the form data
			Document document = new Document("FirstName", firstName).append("LastName", lastName).append("Email", email)
					.append("Qualification", qualification).append("Password", password)
					.append("RetypedPassword", retypedPassword);

			// Insert the document
			collection.insertOne(document);

			// Close the MongoClient when done
			mongoClient.close();
		} catch (Exception e) {
			System.out.println("Error occurred: " + e);
		}
	}

	public boolean sLogin(String email, String password) {
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			MongoClient mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("User_Info");

			// Define the search criteria
			Document query = new Document("Email", email);

			// Perform the search
			MongoCursor<Document> cursor = collection.find(query).iterator();

			// Define your own values for comparison
			String desiredPassword = password;

			while (cursor.hasNext()) {
				Document document = cursor.next();
				// You can process the document here
				String dbpassword = document.getString("Password");

				if (dbpassword.equals(desiredPassword)) {
					cursor.close();

					mongoClient.close();

					return true;
				} else {
					cursor.close();

					mongoClient.close();

					return false;
				}
			}

			// Close the cursor
			cursor.close();

			mongoClient.close();
		} catch (Exception e) {
			System.out.println("Error occurred: " + e);
		}
		return false;
	}

	public boolean TLogin(String email, String password) {
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			MongoClient mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Instructor_Info");

			// Define the search criteria
			Document query = new Document("Email", email);

			// Perform the search
			MongoCursor<Document> cursor = collection.find(query).iterator();

			// Define your own values for comparison
			String desiredPassword = password;

			while (cursor.hasNext()) {
				Document document = cursor.next();
				// You can process the document here
				String dbpassword = document.getString("Password");

				if (dbpassword.equals(desiredPassword)) {
					cursor.close();

					mongoClient.close();

					return true;
				} else {
					cursor.close();

					mongoClient.close();

					return false;
				}
			}

			// Close the cursor
			cursor.close();

			mongoClient.close();
		} catch (Exception e) {
			System.out.println("Error occurred: " + e);
		}
		return false;
	}

	public FindIterable<Document> retrieveUserData(String email) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("User_Info");

			// Define the search criteria
			Document query = new Document("Email", email);

			// Retrieve all user data
			FindIterable<Document> userData = collection.find(query);

			if (userData == null) {
				System.out.println("no user data retrived");
			} else {
				for (Document document : userData) {
					// Access the fields within the document
					String firstName = document.getString("FirstName");
					String lastName = document.getString("LastName");
				}
			}

			return userData;
		} catch (Exception e) {
			System.out.println("Exception " + e.getMessage());
		} finally {
			if (mongoClient != null) {
				// mongoClient.close();
			}
		}
		mongoClient.close();
		return null;

	}

	public FindIterable<Document> retrieveInstructorData(String email) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Instructor_Info");

			// Define the search criteria
			Document query = new Document("Email", email);

			// Retrieve all user data
			FindIterable<Document> userData = collection.find(query);

			if (userData == null) {
				System.out.println("no user data retrived");
			} else {
				System.out.println("data found" + userData);
				for (Document document : userData) {
					// Access the fields within the document
					String firstName = document.getString("FirstName");
					String lastName = document.getString("LastName");

				}
			}

			return userData;
		} catch (Exception e) {
			System.out.println("Exception " + e.getMessage());
		} finally {
			if (mongoClient != null) {

			}
		}
		mongoClient.close();
		return null;
	}

	public FindIterable<Document> updateUserData(String userEmail, String firstName, String lastName) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("User_Info");

			// Define the search criteria (user by email)
			Document query = new Document("Email", userEmail);

			// Create an update document with the new first name and last name
			Document updateDocument = new Document("$set",
					new Document("FirstName", firstName).append("LastName", lastName));

			// Update the user's data
			UpdateResult updateResult = collection.updateOne(query, updateDocument);

			if (updateResult.getModifiedCount() > 0) {
				System.out.println("User data updated successfully.");
			} else {
				System.out.println("No user data updated. User not found or no changes.");
			}

			// Retrieve the updated user data (optional)
			FindIterable<Document> updatedUserData = collection.find(query);

			return updatedUserData;
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
			// Handle the exception appropriately, e.g., log it or rethrow it
		} finally {
			if (mongoClient != null) {
				// mongoClient.close(); // Close the MongoDB client in the "finally" block
			}
		}
		mongoClient.close();
		return null;
	}

	public void UploadCourse(String userEmail, String courseName, String courseDescription, String courseDuration,
			String coursePrice, String discount, String imagePath) {
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			MongoClient mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Courses");

			// Create a document with all the form data
			Document document = new Document("instructorEmail", userEmail).append("courseName", courseName)
					.append("courseDescription", courseDescription).append("courseDuration", courseDuration)
					.append("coursePrice", coursePrice).append("discount", discount).append("courseImage", imagePath);

			// Insert the document
			collection.insertOne(document);

			// Close the MongoClient when done
			mongoClient.close();

		} catch (Exception e) {
			// Handle the exception as needed
			e.printStackTrace();
		}
	}

	public boolean aLogin(String username, String password) {
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			MongoClient mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Admin_Info");

			// Define the search criteria
			Document query = new Document("UserName", username);

			// Perform the search
			MongoCursor<Document> cursor = collection.find(query).iterator();

			// Define your own values for comparison
			String desiredPassword = password;

			while (cursor.hasNext()) {
				Document document = cursor.next();
				// You can process the document here
				String dbpassword = document.getString("Password");

				if (dbpassword.equals(desiredPassword)) {
					cursor.close();

					mongoClient.close();

					return true;
				} else {
					cursor.close();

					mongoClient.close();

					return false;
				}
			}

			// Close the cursor
			cursor.close();

			mongoClient.close();
		} catch (Exception e) {
			System.out.println("Error occurred: " + e);
		}
		return false;
	}

	public FindIterable<Document> retrieveAllUserData() {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("User_Info");

			// Retrieve all user data
			FindIterable<Document> userData = collection.find();

			if (userData == null) {
				System.out.println("No user data retrieved");
				return null;
			}

			return userData;
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {
				// Close the MongoDB client

			}
		}
		mongoClient.close();
		return null;
	}

	public FindIterable<Document> retrieveAllInstructorsData() {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Instructor_Info");

			// Retrieve all user data
			FindIterable<Document> userData = collection.find();

			if (userData == null) {
				System.out.println("No user data retrieved");
				return null;
			}

			return userData;
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {
				// Close the MongoDB client

			}
		}
		mongoClient.close();
		return null;
	}

	public FindIterable<Document> retrieveAllCoursesData() {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Courses");

			// Retrieve all user data
			FindIterable<Document> courseData = collection.find();

			if (courseData == null) {
				System.out.println("No user data retrieved");
				return null;
			}

			return courseData;
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {
				// Close the MongoDB client

			}
		}
		mongoClient.close();
		return null;
	}

	public Document retrieveCourseDataById(String courseId, String userEmail) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Courses");

			// Create a query to find the document by ObjectId and instructor email
			ObjectId objectId = new ObjectId(courseId);
			Document query = new Document("_id", objectId).append("instructorEmail", userEmail);

			// Retrieve the document by the ObjectId and instructor email
			FindIterable<Document> courseData = collection.find(query);

			// Check if the document exists
			if (courseData.iterator().hasNext()) {
				return courseData.first();
			} else {
				System.out.println(
						"No course data found for ObjectId: " + courseId + " and instructorEmail: " + userEmail);
				return null;
			}
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {
				mongoClient.close();
			}
		}
		return null;
	}

	public Document retrieveLessonDataById(String lessonId, String userEmail) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Lesson");

			// Create a query to find the document by ObjectId and instructor email
			ObjectId objectId = new ObjectId(lessonId);
			Document query = new Document("_id", objectId).append("userEmail", userEmail);

			// Retrieve the document by the ObjectId and instructor email
			FindIterable<Document> lessonData = collection.find(query);

			// Check if the document exists
			if (lessonData.iterator().hasNext()) {
				return lessonData.first();
			} else {
				System.out.println(
						"No course data found for ObjectId: " + lessonId + " and instructorEmail: " + userEmail);
				return null;
			}
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {
				mongoClient.close();
			}
		}
		return null;
	}
	
	public Document retrieveCourseDataById(String courseId) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Courses");

			// Create a query to find the document by ObjectId
			ObjectId objectId = new ObjectId(courseId);
			Document query = new Document("_id", objectId);

			// Retrieve the document by the ObjectId and instructor email
			FindIterable<Document> courseData = collection.find(query);

			// Check if the document exists
			if (courseData.iterator().hasNext()) {
				return courseData.first();
			} else {
				System.out.println("No course data found for ObjectId: " + courseId);
				return null;
			}
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {
				mongoClient.close();
			}
		}
		return null;
	}

	public Document retriveUserDataByEmail(String email) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("User_Info");

			// Create a query to find the document by email
			Bson query = Filters.eq("Email", email);

			// Retrieve the document by the email
			Document userDataDocument = collection.find(query).first();

			// Check if the document exists
			if (userDataDocument != null) {
				return userDataDocument;
			} else {
				System.out.println("No user data found for email: " + email);
				return null;
			}
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {
				mongoClient.close();
			}
		}
		return null;
	}

	public FindIterable<Document> retrieveCourseData(String userEmail) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Courses");

			// Define the search criteria with the correct field name
			Document query = new Document("instructorEmail", userEmail);

			// Retrieve course data based on the instructor's email
			FindIterable<Document> courseData = collection.find(query);

			if (courseData == null) {
				System.out.println("No course data retrieved");
			} else {
				System.out.println("Course data found for instructor with email: " + userEmail);
				for (Document document : courseData) {
					// Access the fields within the document
					String courseId = document.getString("courseName");
					String courseName = document.getString("courseName");
					String courseDescription = document.getString("courseDescription");
					String courseDuration = document.getString("courseDuration");
					String coursePrice = document.getString("coursePrice");
					String discount = document.getString("discount");
					String courseImage = document.getString("courseImage");
					// You can access more fields as needed
				}
			}

			return courseData;
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {

			}
		}
		mongoClient.close();
		return null;
	}

	public boolean DeleteCourseById(String course_id) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Courses");

			// Create a filter to find the document to delete
			Bson filter = Filters.eq("_id", new ObjectId(course_id));

			// Perform the delete operation
			DeleteResult deleteResult = collection.deleteOne(filter);

			// Check if a document was deleted
			if (deleteResult.getDeletedCount() > 0) {
				return true;
			}

		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {

			}
		}
		mongoClient.close();
		return false;
	}

	public boolean DeleteLessonById(String lessonId) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Lesson");

			// Create a filter to find the document to delete
			Bson filter = Filters.eq("_id", new ObjectId(lessonId));

			// Perform the delete operation
			DeleteResult deleteResult = collection.deleteOne(filter);

			// Check if a document was deleted
			if (deleteResult.getDeletedCount() > 0) {
				return true;
			}

		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {

			}
		}
		mongoClient.close();
		return false;
	}
	
	public void UpdateCourse(String courseId, String courseName, String courseDescription, String courseDuration,
			String coursePrice, String discount, String relativePath) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Courses");

			// Convert the provided courseId (as a string) to ObjectId
			ObjectId objectId = new ObjectId(courseId);

			// Create a filter to find the document with the specified _id (ObjectId)
	        Document filter = new Document("_id", objectId);

			// Create an update document with the new values
			Document update = new Document("$set", new Document("courseName", courseName).append("courseDescription", courseDescription).append("courseDuration", courseDuration).append("coursePrice", coursePrice).append("discount", discount).append("courseImage", relativePath));
					
			// Update the document
			UpdateResult updateResult = collection.updateOne(filter, update);

			if (updateResult.getModifiedCount() > 0) {
				System.out.println("Document updated successfully");
			} else {
				System.out.println("No document matched the filter.");
			}
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {
				mongoClient.close();
			}
		}
	}

	public void UpdateLesson(String courseId, String userEmail, String courseName, String epno, String eptitle,
			String epdesc, String relativePathvid, String relativePathpdf) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Lesson");

			// Convert the provided courseId (as a string) to ObjectId
			ObjectId objectId = new ObjectId(courseId);

			// Create a filter to find the document with the specified _id (ObjectId)
	        Document filter = new Document("_id", objectId);

			// Create an update document with the new values
			Document update = new Document("$set", new Document("eptitle", eptitle).append("epdesc", epdesc).append("relativePathvid", relativePathvid).append("relativePathpdf", relativePathpdf));
					
			// Update the document
			UpdateResult updateResult = collection.updateOne(filter, update);

			if (updateResult.getModifiedCount() > 0) {
				System.out.println("Document updated successfully");
			} else {
				System.out.println("No document matched the filter.");
			}
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {
				mongoClient.close();
			}
		}
	}
	
	public void UploadLesson(String courseId, String userEmail, String courseName, String epno, String eptitle,
			String epdesc, String relativePathvid, String relativePathpdf) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Lesson");

			// Create a document with the data to insert
			Document lessonDocument = new Document();
			lessonDocument.append("courseId", new ObjectId(courseId)).append("userEmail", userEmail)
					.append("courseName", courseName).append("epno", epno).append("eptitle", eptitle)
					.append("epdesc", epdesc).append("relativePathvid", relativePathvid)
					.append("relativePathpdf", relativePathpdf);

			// Insert the document into the collection
			collection.insertOne(lessonDocument);

		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {

			}
		}
		mongoClient.close();
	}

	public FindIterable<Document> retriveLessonById(String courseId) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Lesson");

			// Create an ObjectId instance from the courseId
			ObjectId courseIdObjectId = new ObjectId(courseId);

			// Define the search criteria using the ObjectId
			Document query = new Document("courseId", courseIdObjectId);

			// Retrieve course data based on the instructor's email
			FindIterable<Document> lessonData = collection.find(query);

			if (lessonData == null) {
				System.out.println("No Lesson data retrieved");
			} else {
				System.out.println("Lesson Data Retrived");
			}
			return lessonData;
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {

			}
		}
		mongoClient.close();
		return null;
	}

	// this is a test code
	public FindIterable<Document> getAllLessonData(String courseId) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Lesson");

			// Create an ObjectId instance from the courseId
			ObjectId courseIdObjectId = new ObjectId(courseId);

			// Define the search criteria using the ObjectId
			Document query = new Document("courseId", courseIdObjectId);

			// Retrieve course data based on the instructor's email
			FindIterable<Document> lessonData = collection.find(query);

			if (lessonData == null) {
				System.out.println("No course data retrieved");
			} else {
				System.out.println("lesson data found for instructor with courseid: " + courseId);
				for (Document document : lessonData) {
					// Access the fields within the document
					System.out.println(document.getString("courseName"));
					// You can access more fields as needed
				}
			}

			return lessonData;
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {

			}
		}
		mongoClient.close();
		return null;
	}
	// test code ends here

	public FindIterable<Document> retrieveCourseData() {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Courses");

			// query to retrive all the data from the course collection
			FindIterable<Document> courseData = collection.find();

			if (courseData == null) {
				System.out.println("No course data retrieved");
			} else {
				System.out.println("Course data found");
				for (Document document : courseData) {
					// Access the fields within the document
					String courseId = document.getString("courseName");
					String courseName = document.getString("courseName");
					String courseDescription = document.getString("courseDescription");
					String courseDuration = document.getString("courseDuration");
					String coursePrice = document.getString("coursePrice");
					String discount = document.getString("discount");
					String courseImage = document.getString("courseImage");
					// You can access more fields as needed
				}
			}

			return courseData;
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {

			}
		}
		mongoClient.close();
		return null;
	}
	
	public void PaymentInfo(String orderID, String razorpayOrderId, ObjectId stdId, String name, String email,
			ObjectId cId, String cName, String cPrice, String cDiscount, String price, String status) {
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			MongoClient mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Payment_Info");

			// Create a document with all the form data
			Document document = new Document("orderId", orderID).append("razorpayId", razorpayOrderId).append("stdId", stdId).append("StudentName", name)
					.append("stdEmail", email).append("courseId", cId).append("courseName", cName).append("coursePrice", cPrice).append("discount", cDiscount).append("DiscountedPrice", price).append("Status", status);

			// Insert the document
			collection.insertOne(document);

			// Close the MongoClient when done
			mongoClient.close();
		} catch (Exception e) {
			System.out.println("Error occurred: " + e);
		}
	}
	
	public void UpdatePaymentInfo(String razorpayorderId, String paymentId, String formattedDateTime) {
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			MongoClient mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Payment_Info");
			
	        // Define the filter to find the document with the specified razorpayorderId
	        Document filter = new Document("razorpayId", razorpayorderId);

	        // Update the document with the new paymentId, formattedDateTime, and set Status to "paid"
	        Document update = new Document("$set", new Document("razorpayPaymentId", paymentId)
	                .append("formattedDateTime", formattedDateTime)
	                .append("Status", "paid"));

	        // Update the document in the collection
	        collection.updateOne(filter, update);

			// Close the MongoClient when done
			mongoClient.close();
		} catch (Exception e) {
			System.out.println("Error occurred: " + e);
		}
	}
	
	public Document RetrivePaymentInfo(String orderId) {
		MongoClient mongoClient = null;
		try {
			// Connect to the MongoDB server
			MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
			mongoClient = new MongoClient(uri);

			// Access the database and collection
			MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
			MongoCollection<Document> collection = database.getCollection("Payment_Info");

			// Create a query to find the document by email
			Bson query = Filters.eq("razorpayId", orderId);

			// Retrieve the document by the email
			Document userDataDocument = collection.find(query).first();

			// Check if the document exists
			if (userDataDocument != null) {
				return userDataDocument;
			} else {
				System.out.println("No user data found for razorpayorderid: " + orderId);
				return null;
			}
		} catch (Exception e) {
			System.out.println("Exception: " + e.getMessage());
		} finally {
			if (mongoClient != null) {
				mongoClient.close();
			}
		}
		return null;
	}
	
	//CAUTION: this is nowhere in use but dont delete it might need for reference in future
	public List<ObjectId> RetrieveCourseIdsByEmail(String stdEmail) {
	    MongoClient mongoClient = null;
	    List<ObjectId> courseIds = new ArrayList<>();

	    try {
	        // Connect to the MongoDB server
	        MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
	        mongoClient = new MongoClient(uri);

	        // Access the database and collection
	        MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
	        MongoCollection<Document> collection = database.getCollection("Payment_info");

	        // Define the filter to find documents with a specific email
	        Bson filter = Filters.eq("stdEmail", stdEmail);

	        // Retrieve all documents that match the filter
	        FindIterable<Document> cursor = collection.find(filter);

	        // Iterate through the cursor and add "courseId" as ObjectId to the list
	        for (Document document : cursor) {
	            ObjectId courseId = document.get("courseId", ObjectId.class);
	            if (courseId != null) {
	                courseIds.add(courseId);
	            }
	        }
	        return courseIds;
	    } catch (Exception e) {
	        System.out.println("Exception: " + e.getMessage());
	    } finally {
	        if (mongoClient != null) {
	            mongoClient.close();
	        }
	    }
	    return null;
	}

	public FindIterable<Document> retrieveAllUserPaymentData(String stdEmail) {
		MongoClient mongoClient = null;
		try {
	        // Connect to the MongoDB server
	        MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
	        mongoClient = new MongoClient(uri);

	        // Access the database and collection
	        MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
	        MongoCollection<Document> collection = database.getCollection("Payment_Info");

	        // Define the filter to find documents with a specific email
	        Document query = new Document("stdEmail", stdEmail);

	        // Retrieve course data based on the instructor's email
	     	FindIterable<Document> userPaymentData = collection.find(query);
	     	
	        return userPaymentData;
	    } catch (Exception e) {
	        System.out.println("Exception: " + e.getMessage());
	    } finally {
	        if (mongoClient != null) {
	            
	        }
	    }
		mongoClient.close();
		return null;
	}
	
	public FindIterable<Document> RetrieveCourseDataById(List<ObjectId> courseIds) {
	    MongoClient mongoClient = null;
	    try {
	        // Connect to the MongoDB server
	        MongoClientURI uri = new MongoClientURI("mongodb://localhost:27017");
	        mongoClient = new MongoClient(uri);

	        // Access the database and collection
	        MongoDatabase database = mongoClient.getDatabase("LearnIt_DB");
	        MongoCollection<Document> collection = database.getCollection("Courses");

	        // Create a query to find the documents by ObjectId in the list of courseIds
	        Document query = new Document("_id", new Document("$in", courseIds));

	        // Retrieve the documents by the ObjectId and instructor email
	        FindIterable<Document> courseData = collection.find(query);

	        return courseData;
	    } catch (Exception e) {
	        System.out.println("Exception: " + e.getMessage());
	    } finally {
	        if (mongoClient != null) {
	            
	        }
	    }
	    mongoClient.close();
	    return null;
	}

	public static void main(String[] args) {
	}

}
