final template = {
  "type": "SizedBox",
  "id": "1",
  "attributes": {
    "width": 400.0,
  },
  "child": {
    "type": "ColoredBox",
    "id": "2",
    "attributes": {
      "color": "#3DFF0000"
    },
    "child": {
      "type": "Column",
      "id": "3",
      "attributes": {
        "crossAxisAlignment": "center"
      },
      "children": [
        {
          "type": "Row",
          "id": "4",
          "attributes": {"mainAxisAlignment": "spaceEvenly"},
          "action": {},
          "children": [
            {
              "type": "Text",
              "id": "5",
              "attributes": {"data": "Very cool ", "textAlign": "start"},
              "action": {},
            },
            {
              "type": "Text",
              "id": "6",
              "attributes": {"data": "remote form", "textAlign": "start"},
              "action": {},
            },
          ]
        },
        {
          "type": "TextField",
          "id": "7",
          "attributes": {
            "style": {
              "color": "#2da871"
            },
            "labelText": "Controlled input!",
            "decoration": {
              "border": {
                "type": "underline",
              }
            }
          }
        },
        {
          "type": "ElevatedButton",
          "id": "8",
          "child": {
            "type": "Text",
            "id": "9",
            "attributes": {"data": "Press me!! ", "textAlign": "start"},
            "action": {},
          },
        },
      ]
    }
  }
};