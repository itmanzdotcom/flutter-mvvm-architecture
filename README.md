# Flutter Base MVVM Architecture

An Introduction to MVVM in Flutter
In this piece, we’ll use the MVVM design pattern to write a complete Flutter application

The Structure seems like [MVVM-Android](https://quickbirdstudios.com/blog/wp-content/uploads/2018/06/9D30D6B2-2689-4F56-B7C6-38AADDE8D51E-768x287.png)。

![](architecture.png)

### Intro
Flutter is a cross-platform framework that allows you to write iOS and Android apps using a single codebase.
By default, Flutter apps don’t use any specific design pattern. This means the developer is in charge of choosing and implementing a pattern that fits their needs. The declarative nature of Flutter makes it an ideal candidate for the MVVM design pattern.

### Understanding MVVM
MVVM stands for Model-View-ViewModel. The basic idea is to create a view model that’ll provide data to the view. The view can use the data provided by the view model to populate itself. Creating a view-model layer allows you to write modular code, which can be used by several views.
The MVVM design pattern originated from Microsoft. MVVM was heavily used in writing Windows Presentation Foundation (WPF) applications. The MVVM pattern is a fancy name for the PresentationModel.

Since design patterns are platform-agnostic, it can be used with any framework, including Flutter.
In this piece, we’ll create a movies app, which will fetch the movies based on an entered keyword and display them to the user. This app will be created based on the MVVM principles. Before diving into the code, check out the animation below to get an idea of the app we’ll be building.

### Dependencies in this base project

- [dio](https://github.com/flutterchina/dio) : netword 
- [rxdart](https://github.com/ReactiveX/rxdart)：reactive programming
- [provider](https://github.com/rrousselGit/provider)：state managing
- [dartin](https://github.com/ditclear/dartin): dependency injection

> PS：each layer connected by rx, use responsive thinking and rxdart operators for logical processing.Finally, update the view with [provider](https://github.com/rrousselGit/provider).

Thanks for reading!
