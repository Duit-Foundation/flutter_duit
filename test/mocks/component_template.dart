final componentTemplate = {
  "tag": "x",
  "layoutRoot": {
    "type": "Column",
    "id": "col1",
    "controlled": false,
    "attributes": {
      "x": "x",
    },
    "children": [
      {
        "type": "Container",
        "id": "container1",
        "controlled": false,
        "attributes": {
          "width": 50,
          "height": 50,
          "refs": [
            {
              "objectKey": "mainColor",
              "attributeKey": "color",
            },
          ],
        },
      },
      {
        "type": "Container",
        "id": "container2",
        "controlled": false,
        "attributes": {
          "width": 50,
          "height": 50,
          "refs": [
            {
              "objectKey": "secColor",
              "attributeKey": "color",
              "defaultValue": "#DCDCDC",
            },
          ],
        },
      }
    ],
  },
};

const componentTemplateData = {
  "secColor": "#03fcc2",
  "mainColor": "#075eeb",
};

const componentTemplateData2 = {
  "mainColor": "#075eeb",
};