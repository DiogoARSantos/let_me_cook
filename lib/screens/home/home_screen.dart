import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState(title: 'Home');
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

class _HomeScreenState extends State<HomeScreen> {
  final String title;

  _HomeScreenState({Key? key, required this.title});

  // Lista fictícia de receitas
  final List<Receita> receitas = [
    Receita(nome: 'Receita 1', foto: 'caminho_foto_1'),
    Receita(nome: 'Receita 2', foto: 'caminho_foto_2'),
    Receita(nome: 'Receita 3', foto: 'caminho_foto_3'),
    Receita(nome: 'Receita 4', foto: 'caminho_foto_4'),
    Receita(nome: 'Receita 5', foto: 'caminho_foto_5'),
    Receita(nome: 'Receita 6', foto: 'caminho_foto_6'),
    // Adicione mais receitas conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Seu Título'),
        actions: [
          // Adiciona um espaçamento de 8 pixels
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                // Ação para o ícone de notificação
              },
              icon: Icon(Icons.notifications, size: 35.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              onPressed: () {
                // Ação para o ícone de configurações
              },
              icon: Icon(Icons.settings, size: 35.0),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10), // Adiciona um espaçamento de 20 pixels
          Text(
            'Receitas',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          buildSearchTextField(context), // Adiciona um espaçamento de 8 pixels
          buildReceitasList(),
        ],
      ),
    );
  }

  Widget buildSearchTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          showSearch(context: context, delegate: DataSearch(allData: receitas));
        },
        decoration: InputDecoration(
          hintText: 'Pesquisar...',
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        ),
      ),
    );
  }

  Widget buildReceitasList() {
    return Expanded(
      child: ListView.builder(
        itemCount: receitas.length,
        itemBuilder: (context, index) {
          return ReceitaCard(receita: receitas[index]);
        },
      ),
    );
  }
}
