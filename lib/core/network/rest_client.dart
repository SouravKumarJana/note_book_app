import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/models/note_model.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  // CREATE
  @POST("/notes")
  Future<NoteModel> createNote(
    @Body() NoteModel note,
  );

  // UPDATE
  @PUT("/notes/{id}")
  Future<NoteModel> updateNote(
    @Path("id") String id,
    @Body() NoteModel note,
  );

  // DELETE
  @DELETE("/notes/{id}")
  Future<void> deleteNote(
    @Path("id") String id,
  );

  // GET ALL (for pull sync)
  @GET("/notes")
  Future<List<NoteModel>> getAllNotes();
}
