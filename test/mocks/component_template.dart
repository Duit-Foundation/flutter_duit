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
        "type": "Text",
        "id": "text1",
        "controlled": false,
        "attributes": {
          "data": "1",
          "refs": [
            {
              "objectKey": "title",
              "attributeKey": "data",
            },
          ],
        },
      },
      {
        "type": "Text",
        "id": "text2",
        "controlled": false,
        "attributes": {
          "data": "2",
          "refs": [
            {
              "objectKey": "description",
              "attributeKey": "data",
              "defaultValue": "DEFAULT",
            },
          ],
        },
      }
    ],
  },
};

const componentTemplateData = {
  "description": "TEXT2",
  "title": "TEXT1",
};

const componentTemplateData2 = {
  "title": "TEXT1",
};