// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../category/cubit/category_details_view_model.dart' as _i165;
import '../repository/news/data_sources/news_local_data_source_impl.dart'
    as _i967;
import '../repository/news/data_sources/news_remote_data_source_impl.dart'
    as _i306;
import '../repository/news/news_data_source.dart' as _i604;
import '../repository/news/news_repository_contract.dart' as _i295;
import '../repository/news/repository/news_repository_impl.dart' as _i941;
import '../repository/sources/data_sources/source_local_data_source_impl.dart'
    as _i332;
import '../repository/sources/data_sources/source_remote_data_source_impl.dart'
    as _i972;
import '../repository/sources/repository/source_repository_impl.dart' as _i892;
import '../repository/sources/source_data_source.dart' as _i460;
import '../repository/sources/source_repository_contract.dart' as _i995;
import '../ui/screen/home_screen/news/cubit/news_details_view_model.dart'
    as _i449;
import '../ui/utilites/api_manger.dart' as _i245;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i245.ApiManager>(() => _i245.ApiManager());
    gh.factory<_i604.NewsRemoteDataSource>(() =>
        _i306.NewsRemoteDataSourceImpl(apiManager: gh<_i245.ApiManager>()));
    gh.factory<_i460.SourceLocalDataSource>(
        () => _i332.SourceLocalDataSourceImpl());
    gh.factory<_i460.SourceRemoteDataSource>(() =>
        _i972.SourceRemoteDataSourceImpl(apiManager: gh<_i245.ApiManager>()));
    gh.factory<_i604.NewsLocalDataSource>(
        () => _i967.NewsLocalDataSourceImpl());
    gh.factory<_i995.SourceRepositoryContract>(() => _i892.SourceRepositoryImpl(
          remoteDataSource: gh<_i460.SourceRemoteDataSource>(),
          localDataSource: gh<_i460.SourceLocalDataSource>(),
        ));
    gh.factory<_i165.CategoryDetailsViewModel>(() =>
        _i165.CategoryDetailsViewModel(
            repositoryContract: gh<_i995.SourceRepositoryContract>()));
    gh.factory<_i295.NewsRepositoryContract>(() => _i941.NewsRepositoryImpl(
          remoteDataSource: gh<_i604.NewsRemoteDataSource>(),
          localDataSource: gh<_i604.NewsLocalDataSource>(),
        ));
    gh.factory<_i449.NewsDetailsViewModel>(() => _i449.NewsDetailsViewModel(
        repositoryContract: gh<_i295.NewsRepositoryContract>()));
    return this;
  }
}
