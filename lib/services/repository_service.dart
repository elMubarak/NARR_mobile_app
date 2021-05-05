import 'package:narr/configs.dart';
import 'package:narr/models/repository_model.dart';
import 'package:narr/services/backend_service.dart';

String researchRepoUrl = '$serverUrl/research';

class RepoService {
  Future<List<RepositoryModel>> getRepositories() async {
    List researchListFromJson =
        await NetworkHelper(url: researchRepoUrl).getResearchRepo();
    List<RepositoryModel> researchList = <RepositoryModel>[];
    for (final dynamic repoJson in researchListFromJson) {
      researchList.add(
        RepositoryModel.fromJson(repoJson),
      );
    }
    return Future<List<RepositoryModel>>.value(researchList);
  }
}
