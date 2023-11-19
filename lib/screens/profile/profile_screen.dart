import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState(title: 'Profile');
}

class DataSearch extends SearchDelegate<String> {
  final List<Receita> allData; // Substitua com seus próprios dados

  DataSearch({required this.allData});

  List<Receita> get _currentRecipes {
    return query.isEmpty
        ? allData
        : allData
            .where((receita) =>
                receita.nome.toLowerCase().contains(query.toLowerCase()))
            .toList();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: _currentRecipes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_currentRecipes[index].nome),
          onTap: () {
            close(context, _currentRecipes[index].nome);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: _currentRecipes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_currentRecipes[index].nome),
          onTap: () {
            query = _currentRecipes[index].nome;
            showResults(context);
          },
        );
      },
    );
  }
}

class Receita {
  final String nome;
  final String foto;

  Receita({required this.nome, required this.foto});
}

class ReceitaCard extends StatelessWidget {
  final Receita receita;

  ReceitaCard({required this.receita});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(receita.foto),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              receita.nome,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyAppState2 extends ChangeNotifier {
  final List<Receita> favorites = [
    Receita(nome: 'Favorite 1', foto: 'caminho_foto_1'),
    Receita(nome: 'Favorite 2', foto: 'caminho_foto_2'),
    // Adicione mais receitas favoritas conforme necessário
  ];
  final List<Receita> recipes = [
    Receita(nome: 'Recipe 1', foto: 'caminho_foto_3'),
    Receita(nome: 'Recipe 2', foto: 'caminho_foto_4'),
    // Adicione mais receitas conforme necessário
  ];

  List<Receita> get displayedRecipes {
    return _displayFavorites ? favorites : recipes;
  }

  bool _displayFavorites = false;

  void toggleDisplayFavorites() {
    _displayFavorites = !_displayFavorites;
    notifyListeners();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String title;

  _ProfileScreenState({Key? key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState2(),
      child: Consumer<MyAppState2>(
        builder: (context, appState2, child) {
          Widget buildHeader() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('caminho_para_a_sua_imagem'),
                ),
                SizedBox(height: 10),
                Text(
                  'Wilker Martins',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
              ],
            );
          }

          Widget buildButtons() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print('button pressed!');
                      appState2.toggleDisplayFavorites();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: appState2._displayFavorites
                          ? Colors.transparent
                          : Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('As minhas receitas'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print('button pressed!');
                      appState2.toggleDisplayFavorites();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: appState2._displayFavorites
                          ? Colors.green
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Favoritos'),
                  ),
                ),
              ],
            );
          }

          Widget buildSearchTextField() {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  showSearch(
                    context: context,
                    delegate: DataSearch(allData: appState2.displayedRecipes),
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Pesquisar...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                ),
              ),
            );
          }

          Widget buildReceitasList() {
            return Expanded(
              child: ListView.builder(
                itemCount: appState2.displayedRecipes.length,
                itemBuilder: (context, index) {
                  return ReceitaCard(
                    receita: appState2.displayedRecipes[index],
                  );
                },
              ),
            );
          }

          return Scaffold(
            body: Column(
              children: [
                buildHeader(),
                buildButtons(),
                buildSearchTextField(),
                buildReceitasList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
