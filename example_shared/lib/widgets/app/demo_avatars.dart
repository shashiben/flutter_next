import 'dart:convert';

import 'package:flutter/material.dart';

/// Base64 encoded solid-color PNGs used by the avatar demos.
const List<String> _demoAvatarSources = <String>[
  'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAT0lEQVR42u3PQQkAAAg'
      'EsCtqBOv7NoJvYbACS9e8FgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE'
      'BAQEBAQEBAQEBAQGBywI2kQGlSkyruQAAAABJRU5ErkJggg==',
  'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAATklEQVR42u3PQQkAAAg'
      'EsOt5vc1jBN/CYAWWdl6LgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA'
      'gICAgICAgICAgMBlAX49wWkJlHcHAAAAAElFTkSuQmCC',
  'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAT0lEQVR42u3PQQkAAAg'
      'EsCtkUetY0Ai+hcEKLDX9WgQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE'
      'BAQEBAQEBAQEBAQELgtdMqFLAdQeigAAAABJRU5ErkJggg==',
  'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAT0lEQVR42u3PQQkAAAg'
      'EsOtlWtsZwwi+hcEKLNP1WgQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE'
      'BAQEBAQEBAQEBAQELgvyJkGlWLyctQAAAABJRU5ErkJggg==',
  'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAT0lEQVR42u3PQQkAAAg'
      'EsGtoIJPaxgi+hcEKLFP9WgQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE'
      'BAQEBAQEBAQEBAQELgsXXzGHZCiIJQAAAABJRU5ErkJggg==',
];

/// Initials shown on top of the demo avatars.
const List<String> kDemoAvatarInitials = <String>['MC', 'OB', 'PR', 'JW', 'AN'];

/// Small colored avatars used by the example apps.
final List<MemoryImage> kDemoAvatars = List<MemoryImage>.generate(
  _demoAvatarSources.length,
  (index) => MemoryImage(base64Decode(_demoAvatarSources[index])),
  growable: false,
);
