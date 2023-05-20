part of '../map_route.dart';

final _mediaKey = GlobalKey<NavigatorState>();

const String addMediaRoute = '/addMedia';
const String previewMediaRoute = 'previewMedia';
const String photoAlbum = 'photoAlbum';

final ShellRoute addMediaShell = ShellRoute(navigatorKey: _mediaKey, routes: [
  GoRoute(
      path: addMediaRoute,
      pageBuilder: (_, GoRouterState state) => _bottomUpTransition(
            const CameraScreen(),
          ),
      routes: [
        GoRoute(
            path: previewMediaRoute,
            builder: (BuildContext context, GoRouterState state) =>
                const PreviewScreen()),
        GoRoute(
            path: photoAlbum,
            pageBuilder: (_, GoRouterState state) =>
                _bottomUpTransition(const PhotoAlbumScreen()))
      ]),
]);
