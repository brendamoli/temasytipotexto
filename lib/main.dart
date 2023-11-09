import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cambio de Tema',
      theme: ThemeData.light(),
      home: ThemePage(),
    );
  }
}

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  int _currentIndex = 0;
  Color _backgroundColor = Colors.white;
  String _displayText = 'Texto Personalizado';
  double _fontSize = 16.0;
  Color _textColor = Colors.black;
  FontWeight _fontWeight = FontWeight.normal;
 String _fontFamily = 'Arial';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cambio de Tema'),
      ),
      body: _buildBody(),
      backgroundColor: _backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Temas',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _displayText,
              style: TextStyle(
                color: _textColor,
                fontSize: _fontSize,
                fontWeight: _fontWeight,
                fontFamily: _fontFamily,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showTextDialog();
              },
              child: Text('Personalizar Texto'),
            ),
          ],
        ),
      );
    } else if (_currentIndex == 1) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _changeTheme(ThemeData.light(), Colors.white);
              },
              child: Text('Tema Claro'),
            ),
            ElevatedButton(
              onPressed: () {
                _changeTheme(ThemeData.dark(), Colors.black);
              },
              child: Text('Tema Oscuro'),
            ),
            ElevatedButton(
              onPressed: () {
                _changeTheme(
                  ThemeData.from(
                    colorScheme: ColorScheme.light(primary: Colors.purple),
                  ),
                  Colors.white,
                );
              },
              child: Text('Tema Personalizado'),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Text(
          'Página 3',
          style: TextStyle(fontSize: 30),
        ),
      );
    }
  }
  
//codigo que hace el cambio de tema en la aplicacion
//cambiamos el tema en toda la aplicacion

  void _changeTheme(ThemeData newTheme, Color backgroundColor) {
    setState(() {
      _backgroundColor = backgroundColor;
      if (newTheme != ThemeData.light() && newTheme != ThemeData.dark()) {
        runApp(
          MaterialApp(
            title: 'Cambio de Tema',
            theme: newTheme,
            home: ThemePage(),
          ),
        );
      } else {
        runApp(
          MaterialApp(
            title: 'Cambio de Tema',
            theme: newTheme,
            home: ThemePage(),
          ),
        );
      }
      _currentIndex = 0;
    });
  }

//alertDialog
  void _showTextDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildTextDialog();
      },
    );
  }
//Aqui empieza el alertdialog que se habre al hacer click en el boton 
//personalizar texto

  AlertDialog _buildTextDialog() {
    return AlertDialog(
      title: Text('Personalizar Texto'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Texto'),
              onChanged: (value) {
                setState(() {
                  _displayText = value;
                });
              },
            ),
            SizedBox(height: 10),

            //Aqui se le cambia el tamaño de fuente al texto
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Tamaño Fuente'),
                Slider(
                  value: _fontSize,
                  min: 10,
                  max: 120,
                  onChanged: (value) {
                    setState(() {
                      _fontSize = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),

            //este es el boton para cabiar el color del texto 
            //canbia el color del texto

            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Seleccionar Color'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          pickerColor: _textColor,
                          onColorChanged: (color) {
                            setState(() {
                              _textColor = color;
                            });
                          },
                        ),
                      ),

                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Aceptar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Color del Texto'),
            ),

             SizedBox(height: 10),

             //aqui en pieza el codigo para darle un estilo de fuente al texto
            //cambia el tipo de texto

            DropdownButton<String>(
              value: _fontFamily,
              items: <String>[
                'Roboto',
                'Arial',
                'Courier New',
                'Comic Sans MS',
                'Bahnschrift',
                'Arial Black',
                'Times New Roman',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _fontFamily = value!;
                });
              },
            ),
            SizedBox(height: 10),

            //este es el boton para cerrar el alertdialog
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Aceptar'),
          ),
          ],
        ),
      ),
    );
  }
}
