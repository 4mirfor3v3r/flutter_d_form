
# Flutter dynamic_form is a library to get form based on Json

## Supported Fields
- textfield

## Setup installation
in `pubspec.yaml` add this library to your project
```yaml
dependencies:
  d_form:
    git:
      url: https://github.com/4mirfor3v3r/flutter_d_form.git
      ref: master
```

example usage in dart file
```dart
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<Map<String, dynamic>> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    return await jsonDecode(response);
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: readJson(),
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                return DForm(formMap: snapshot.data?['fields']!, formKey: formKey); // Just Call this widget
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          ElevatedButton(onPressed: (){
            if(formKey.currentState!.validate()){
              formKey.currentState!.save();
            }
          }, child: const Text("Submit"))
        ],
      ),
    );
  }
}
```

## Json File
```json
{
  "formName": "Sample Form",
  "fields": [
    {
      "id": "name",
      "label": "Name",
      "hint": "Enter your full name",
      "type": "text",
      "value": "",
      "validation": [
        {
          "type": "required",
          "error": "Name is required"
        },
        {
          "type": "minLength",
          "value": 3,
          "error": "Name must be at least 3 characters long"
        },
        {
          "type": "maxLength",
          "value": 50,
          "error": "Name must be at most 50 characters long"
        },
        {
          "type": "pattern",
          "value": "^[a-zA-Z ]+$",
          "error": "Name must contain only alphabets and spaces"
        }
      ]
    }
  ]
}
```
## Result
![image](https://github.com/user-attachments/assets/092214a3-e97e-406b-bc26-846532832338)

