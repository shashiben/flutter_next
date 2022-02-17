# Flutter Next

<a href="https://www.buymeacoffee.com/shashiben" target="_blank"><img align="right" src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

[![pub package](https://img.shields.io/pub/v/flutter_next)](https://pub.dev/packages/flutter_next)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
<a href="https://github.com/shashiben/flutter_next"><img src="https://img.shields.io/github/stars/shashiben/flutter_next.svg?style=flat&logo=github&label=stars" alt="Star on Github"></a>
<a href="https://github.com/shashiben/flutter_next"><img src="https://img.shields.io/github/forks/shashiben/flutter_next.svg?style=flat&logo=github&label=fork" alt="Star on Github"></a>
<br>
<br>

<p  align="center">
<img  src="example/assets/Flutter Next.png"/>
<br>
<b>Now build flutter apps with ease and responsive.</b>
</p>
<br>

An advanced flutter package to build responsive application accross all platform with ease and has an handful of different types of extension.

- [Alerts](#alerts)
- [Grid System](#grid-system)

## Alerts

Define an alert by:

```dart
  NextAlert(
    child: Text("Yo, this is primary alert"),
    onClosedIconPressed: () {},
    margin: EdgeInsets.only(bottom: 15),
  ),
```

You can use multiple variant of alerts

```dart
  NextAlert(
    variant: NextVariant.secondary,
    child: Text("Yo, this is primary alert"),
    onClosedIconPressed: () {},
    margin: EdgeInsets.only(bottom: 15),
  ),
```

And you can even define custom,variant should be custom

```dart
 NextAlert(
    variant: NextVariant.custom,
    customConfigs: NextAlertColorUtils(
      borderColor: Colors.black,
      backgroundColor: Colors.pink,
      color: Colors.deepOrange,
    ),
    child: Text("Yo, this is primary alert"),
    onClosedIconPressed: () {},
    margin: EdgeInsets.only(bottom: 15),
  ),
```

<img  src="example/assets/alert_example.png"/>

## Grid System

<table class="table table-bordered table-striped">
  <thead>
    <tr>
      <th></th>
      <th class="text-center">
        Extra small<br>
        <small>&lt;576px</small>
      </th>
      <th class="text-center">
        Small<br>
        <small>≥576px</small>
      </th>
      <th class="text-center">
        Medium<br>
        <small>≥768px</small>
      </th>
      <th class="text-center">
        Large<br>
        <small>≥992px</small>
      </th>
      <th class="text-center">
        Extra large<br>
        <small>≥1200px</small>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th class="text-nowrap" scope="row">Max container width</th>
      <td>None (auto)</td>
      <td>540px</td>
      <td>720px</td>
      <td>960px</td>
      <td>1140px</td>
    </tr>
    <tr>
      <th class="text-nowrap" scope="row">Class prefix</th>
      <td><code>.col-</code></td>
      <td><code>.col-sm-</code></td>
      <td><code>.col-md-</code></td>
      <td><code>.col-lg-</code></td>
      <td><code>.col-xl-</code></td>
    </tr>
  </tbody>
</table>
<img src="example/assets/grid_example.gif" height=300>
