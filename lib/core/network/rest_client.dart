import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/models/note_model.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST("/notes")
  Future<void> createNote(@Body() NoteModel note);

  @DELETE("/notes/{id}")
  Future<void> deleteNote(@Path("id") String id);
} 
