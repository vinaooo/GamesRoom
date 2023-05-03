import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  String palavra = '';
  String palavraMascarada = '';
  List<String> letrasErradas = [];
  int erros = 0;
  bool fimDeJogo = false;
  bool jogador1 = true;
  int pontosJogador1 = 0;
  int pontosJogador2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Forca'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              jogador1 ? 'Jogador 1' : 'Jogador 2',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            if (palavraMascarada.isNotEmpty) ...[
              Text(
                palavraMascarada,
                style: const TextStyle(fontSize: 36),
              ),
              const SizedBox(height: 16),
            ],
            if (erros > 0) ...[
              Text(
                'Erros: ${letrasErradas.join(', ')}',
                style: const TextStyle(fontSize: 24, color: Colors.red),
              ),
              const SizedBox(height: 16),
            ],
            if (fimDeJogo) ...[
              Text(
                erros < 6 ? 'Você ganhou!' : 'Você perdeu!',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: reiniciar,
                child: const Text('Novo jogo'),
              ),
            ],
            if (!fimDeJogo && palavraMascarada.isNotEmpty) ...[
              TextField(
                onSubmitted: (letra) => adivinharLetra(letra),
                maxLength: 1,
                decoration: const InputDecoration(
                  hintText: 'Digite uma letra',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => adivinharPalavra(),
                child: const Text('Chutar palavra'),
              ),
            ],
            const SizedBox(height: 32),
            Text(
              'Placar: Jogador 1 $pontosJogador1 x $pontosJogador2 Jogador 2',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: palavraMascarada.isEmpty ? criarPalavra : null,
        child: const Icon(Icons.add),
      ),
    );
  }

  void criarPalavra() async {
    final novaPalavra = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Criar nova palavra'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            autofocus: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
            onSaved: (value) => palavra = value!,
            maxLength: 20,
            decoration: const InputDecoration(hintText: 'Digite a palavra'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final form = _formKey.currentState!;
              if (form.validate()) {
                form.save();
                Navigator.pop(context, palavra);
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    if (novaPalavra != null && novaPalavra.isNotEmpty) {
      palavra = novaPalavra.toUpperCase();
      palavraMascarada = '_ ' * palavra.length;
      setState(() {});
    }
  }

  void adivinharLetra(String letra) {
    letra = letra.toUpperCase();
    if (palavra.contains(letra)) {
      for (int i = 0; i < palavra.length; i++) {
        if (palavra[i] == letra) {
          palavraMascarada =
              palavraMascarada.replaceFirst('_ ', '$letra ', i * 2);
        }
      }
      if (!palavraMascarada.contains('_')) {
        fimDeJogo = true;
        if (jogador1) {
          pontosJogador1++;
        } else {
          pontosJogador2++;
        }
      }
    } else {
      erros++;
      letrasErradas.add(letra);
      if (erros == 6) {
        fimDeJogo = true;
        if (jogador1) {
          pontosJogador2++;
        } else {
          pontosJogador1++;
        }
      }
    }
    setState(() {});
    jogador1 = !jogador1;
  }

  void adivinharPalavra() async {
    final palavraAdivinhada = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Adivinhar palavra'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            autofocus: true,
            maxLength: 20,
            decoration: InputDecoration(hintText: 'Digite a palavra'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Digite uma palavra';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final form = _formKey.currentState!;
              if (form.validate()) {
                form.save();
                Navigator.pop(
                    context, form.fields['palavra']!.value.toString());
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    if (palavraAdivinhada != null &&
        palavraAdivinhada.toUpperCase() == palavra) {
      fimDeJogo = true;
      if (jogador1) {
        pontosJogador1++;
      } else {
        pontosJogador2++;
      }
    } else {
      erros = 6;
      fimDeJogo = true;
      if (jogador1) {
        pontosJogador2++;
      } else {
        pontosJogador1++;
      }
    }
    setState(() {});
    jogador1 = !jogador1;
  }

  void reiniciar() {
    palavra = '';
    palavraMascarada = '';
    letrasErradas.clear();
    erros = 0;
    fimDeJogo = false;
    setState(() {});
  }
}
