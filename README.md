# custom_search_page

A web Flutter project, for import different search engine

## deploy
[https://shadowplusing.website/custom_search_page/](https://shadowplusing.website/custom_search_page/)

## support
1. [sembast](https://pub.dev/packages/sembast)
2. [sembast_web](https://pub.dev/packages/sembast_web)
3. [get_it](https://pub.dev/packages/get_it)

## Getting Started
solve flutter web font download event causes bad website speed, change use html render.

flutter run --web-renderer html

flutter build web --web-renderer html --release

## flutter web build
index.html
```
    <base href="/">
=>
    <base href="/custom_search_page/">
```
