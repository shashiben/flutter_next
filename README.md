# Flutter Next

<a href="https://www.buymeacoffee.com/shashiben" target="_blank"><img align="right" src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

[![pub package](https://img.shields.io/pub/v/flutter_next)](https://pub.dev/packages/flutter_next)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![popularity](https://badges.bar/flutter_next/popularity)](https://pub.dev/packages/flutter_next/score)
[![likes](https://badges.bar/flutter_next/likes)](https://pub.dev/packages/flutter_next/score)
[![pub points](https://badges.bar/flutter_next/pub%20points)](https://pub.dev/packages/flutter_next/score)
<a href="https://github.com/shashiben/flutter_next"><img src="https://img.shields.io/github/stars/shashiben/flutter_next.svg?style=flat&logo=github&label=stars" alt="Star on Github"></a>
<a href="https://github.com/shashiben/flutter_next"><img src="https://img.shields.io/github/forks/shashiben/flutter_next.svg?style=flat&logo=github&label=fork" alt="Star on Github"></a>
<br>
<br>

<p  align="center">
<img  src="https://raw.githubusercontent.com/shashiben/flutter_next/master/example/assets/Flutter%20Next.png"/>
<br>
<b>Now build flutter apps with ease and responsive.</b>
</p>
<br>

An advanced flutter package to build responsive application accross all platform with ease and has an handful of different types of extension.

## Features

- Develop Responsive Ui
- Add animations with single line
- Handful of extension

## Usage/Examples

🔗 [One Page](https://one-page-with-flutter.netlify.app/)

## Appendix

- [Widgets](#widgets)

  - [Avatar](#avatar)
  - [Hover Widget](#hover-widget)
  - [BreadCumb](#breadcumb)
  - [Alerts](#alerts)
  - [Grid System](#grid-system)
  - [Container](#container)
  - [Accordion](#accordion)
  - [Button](#button)

- [Animations](#animations)

- [Extensions](#extensions)
  - [Context](#context)
  - [Padding](#padding)
  - [String](#string)
  - [Bool](#bool)
- [Shadows](#shadows)

# Widgets

## Avatar

<img src="https://raw.githubusercontent.com/shashiben/flutter_next/master/example/assets/avatar_example.png">

```dart
  Text(
    "Avatar Group",
    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  ),
  SizedBox(
    height: 15,
  ),
  NextAvatarGroup(
      backgroundColor: Colors.orange,
      imagesList: List.generate(
          6,
          (index) => NetworkImage(
              "https://images.ctfassets.net/hrltx12pl8hq/qGOnNvgfJIe2MytFdIcTQ/429dd7e2cb176f93bf9b21a8f89edc77/Images.jpg?fit=fill&w=175&h=175&fm=webp"))),
  Text(
    "Custom Avatar Group",
    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  ),
  SizedBox(
    height: 15,
  ),
  NextAvatarGroup(
    backgroundColor: Colors.orange,
    itemCount: 6,
    widthFactor: 0.8,
    imagesList: List.generate(
        10,
        (index) => NetworkImage(
            "https://images.ctfassets.net/hrltx12pl8hq/qGOnNvgfJIe2MytFdIcTQ/429dd7e2cb176f93bf9b21a8f89edc77/Images.jpg?fit=fill&w=175&h=175&fm=webp")),
    itemBuilder: (context, index, image) => Stack(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              image: DecorationImage(image: image),
              border: Border.all(color: Colors.orange, width: 1.5),
              color: Colors.red,
              borderRadius: BorderRadius.circular(10)),
        ),
        if (index % 3 == 0)
          Positioned(
            bottom: 0,
            left: 0,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 5,
            ),
          )
      ],
    ),
  ),
      Text(
        "Avatar Group Limit count",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 15,
      ),
      NextAvatarGroup(
        backgroundColor: Colors.orange,
        limitTo: 5,
        imagesList: List.generate(
            10,
            (index) => NetworkImage(
                "https://images.ctfassets.net/hrltx12pl8hq/qGOnNvgfJIe2MytFdIcTQ/429dd7e2cb176f93bf9b21a8f89edc77/Images.jpg?fit=fill&w=175&h=175&fm=webp")),
        widthFactor: 0.5,
      )
```

## Hover Widget

Using this you can know whether widget is hovered or not. Even it works for mobile and every device.

`Hover Duration` - Duration for returning from hover to normal state

```dart
  HoverWidget(
    builder:(context,isHovered)=>Container(child:....)
  )
```

## BreadCumb

<img  src="https://raw.githubusercontent.com/shashiben/flutter_next/master/example/assets/breadcumb_example.png"/>

```dart
   NextBreadCumb(
      childrens: ["Home", "Dashboard", "Payment", "Checkout"]
          .map((e) => NextBreadCumbItem(child: (isHovered) => Text(e)))
          .toList()),
    SizedBox(height: 20),
    Text("With Custom Separator"),
    SizedBox(height: 10),
    NextBreadCumb(
        seperator: Text("---"),
        childrens: ["A", "B", "C", "D", "E", "F", "G", "H"]
            .map(
              (e) => NextBreadCumbItem(child: (isHovered) => Text(e)),
            )
            .toList()),
```

Additionally you can provide variant

- Wrap (If exceeds more than width then it will move to next line)
- Scroll (It will scroll horizontally)

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

<img  src="https://raw.githubusercontent.com/shashiben/flutter_next/master/example/assets/alert_example.png"/>

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
      <td><code>col-</code></td>
      <td><code>col-sm-</code></td>
      <td><code>col-md-</code></td>
      <td><code>col-lg-</code></td>
      <td><code>col-xl-</code></td>
    </tr>
  </tbody>
</table>

```dart
NextRow(
  verticalSpacing: 15,
  horizontalSpacing: 15,
  children: [
    "col-12 col-md-6 col-lg-4",
    "col-12 col-md-6 col-lg-4",
    "col-12 col-md-3 col-lg-4 col-sm-6 col-xs-6",
    "col-12 col-md-3 col-lg-4 col-sm-6 col-xs-6"
  ]
      .map((e) => NextCol(
          sizes: e,
          child: Container(
            height: 100,
            decoration: BoxDecoration(color: Colors.orange),
            child: Center(
              child: Text(
                e,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            width: double.infinity,
          )))
      .toList())
```

<img src="https://raw.githubusercontent.com/shashiben/flutter_next/master/example/assets/grid_example.gif" height=300>

## Container

<table class="table">
  <thead>
    <tr>
      <td class="border-dark"></td>
      <th scope="col">
        Extra small<br>
        <span class="fw-normal">&lt;576px</span>
      </th>
      <th scope="col">
        Small<br>
        <span class="fw-normal">≥576px</span>
      </th>
      <th scope="col">
        Medium<br>
        <span class="fw-normal">≥768px</span>
      </th>
      <th scope="col">
        Large<br>
        <span class="fw-normal">≥992px</span>
      </th>
      <th scope="col">
        X-Large<br>
        <span class="fw-normal">≥1200px</span>
      </th>
      <th scope="col">
        XX-Large<br>
        <span class="fw-normal">≥1400px</span>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row" class="fw-normal"><code>Next Container</code></th>
      <td class="text-muted">100%</td>
      <td>540px</td>
      <td>720px</td>
      <td>960px</td>
      <td>1140px</td>
      <td>1320px</td>
    </tr>
  </tbody>
</table>

- If you pass fluid as true then it will take whole width

## Accordion

```dart
 NextAccordion(
    initiallyExpanded: true,
    backgroundColor: Colors.white,
    collapsedBackgroundColor: Colors.white,
    title: Text("Hey this it title which is initially Expanded"),
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: NextAlert(
          child: Text("Yo this is child"),
        ),
      )
    ],
  ),
```

<img src="https://raw.githubusercontent.com/shashiben/flutter_next/master/example/assets/accordion_example.png">

## Button

<img src="https://raw.githubusercontent.com/shashiben/flutter_next/master/example/assets/button_example.gif">

You can customise button by using itemBuilder

```dart
   NextButton(
    onPressed: () {},
    style: TextStyle(color: Colors.white),
    child: Text(
      "Filled Button",
      style: TextStyle(color: Colors.white),
    ),
  ),
  SizedBox(height: 20),
  NextButton(
    onPressed: () {},
    variant: NextButtonVariant.outlined,
    child: Text("Outline Button"),
  ),
  NextButton(
    onPressed: () {},
    variant: NextButtonVariant.outlined,
    itemBuilder: (context, isHovered, color) =>
        Icon(Icons.headset_rounded, color: color)
            .paddingSymmetric(horizontal: 20, vertical: 10)
            .decoration(BoxDecoration(
              border:
                  Border.all(color: context.primaryColor, width: 1.5),
              color: !isHovered ? context.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(8),
            )),
  )
```

- the param color in itemBuilder is a color tween between color and outline color provided in button

## Animations

<img src="https://raw.githubusercontent.com/shashiben/flutter_next/master/example/assets/animation_example.gif">

```dart
 Text("Fade In Animations").customPadding(bottom: 20),
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ContainerThing().fadeIn(
          variant: NextFadeInVariant.fadeInLeft,
          duration: Duration(milliseconds: 600)),
      ContainerThing().fadeIn(
          variant: NextFadeInVariant.fadeInTop,
          duration: Duration(milliseconds: 600)),
      ContainerThing().fadeIn(
          variant: NextFadeInVariant.fadeInBottom,
          duration: Duration(milliseconds: 600)),
      ContainerThing().fadeIn(
          variant: NextFadeInVariant.fadeInRight,
          duration: Duration(milliseconds: 600)),
    ],
  ),
  SizedBox(height: 20),
  Text("Fade out Animations").customPadding(bottom: 20),
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ContainerThing(
        color: Colors.red,
      ).fadeOut(
          variant: NextFadeOutVariant.fadeOutLeft,
          duration: Duration(milliseconds: 600)),
      ContainerThing(
        color: Colors.red,
      ).fadeOut(
          variant: NextFadeOutVariant.fadeOutTop,
          duration: Duration(milliseconds: 600)),
      ContainerThing(
        color: Colors.red,
      ).fadeOut(
          variant: NextFadeOutVariant.fadeOutBottom,
          duration: Duration(milliseconds: 600)),
      ContainerThing(
        color: Colors.red,
      ).fadeOut(
          variant: NextFadeOutVariant.fadeOutRight,
          duration: Duration(milliseconds: 600)),
    ],
  ),
  SizedBox(height: 20),
  Text("Flip Animations").customPadding(bottom: 20),
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ContainerThing(
        color: Colors.yellow,
      ).flip(
          variant: NextFlipVariant.flipX,
          duration: Duration(milliseconds: 600)),
      ContainerThing(
        color: Colors.yellow,
      ).flip(
          variant: NextFlipVariant.flipY,
          duration: Duration(milliseconds: 600)),
    ],
  ),
  SizedBox(height: 20),
  Text("Zoom Animations").customPadding(bottom: 20),
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ContainerThing().zoom(variant: NextZoomVariant.zoomIn),
      ContainerThing().zoom(variant: NextZoomVariant.zoomOut),
    ],
  )
```

## Extensions

## Context

Now access themedata and mediaquery data easily like

```dart
  context.themeData
  context.textTheme
  context.buttonTheme
  context.snackBarTheme
```

Or if you want to develop responsive views w.r.t height and width

```dart
  context.height
  context.width
```

And for colors

```dart
  context.primaryColor
  context.backgroundColor
  context.canvasColor
  context.dividerColor
```

And for Widgets

```dart
/// Instead of this
Center(
  child:Container(
    child:....
  )
)
// You can write like this
Container(
  child:....
).center()

//Now you can use column/row/stack like this
[Widget1(),Widget2(),Widget3()]column()
```

## Padding

Instead of

```dart
Padding(
  padding: const EdgeInsets.all(20)
  child:Widget(
    child...
  )
)
```

You can use

```dart
Widget(
  child:...
).pad(20)
// Or
Widget(
  child:...
).paddingSymmetric(horizontal:20,vertical:12)
//or
Widget(
  child:...
).customPadding(left:10,right:12)
```

## String

- We provide handful of string extensions
  - `"string".capitalize()` // Output is: String
  - `"45".toInt()` // Output is: 45
  - `"45.4".toDouble()` // Output is: 45.4
  - `"flutter".isInt()` //Output is: False
  - `"flutter".isDouble()` //Output is: False
  - `"flutter".toDouble() `//Output is: null

## Bool

- `false.toggle()` //Output is true

# Shadows

<img src="https://raw.githubusercontent.com/shashiben/flutter_next/master/example/assets/shadows_example.png">

```dart
  ContainerThing(
    shadows: NextShadow.shadow100()
  ),
```

- Additionally you can provide customshadow color

```dart
  ContainerThing(
    shadows: NextShadow.shadow100(color:Colors.red)
  ),
```

## 🔗 Links

[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://shashiben.me/)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/shashi-kumar-58ab1b1a4/)
[![twitter](https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/Shashi35744438)

# Contributions

- Contributions are always welcome
- Follow the linting
