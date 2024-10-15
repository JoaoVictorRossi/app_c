import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Produto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductFormPage(),
    );
  }
}

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _nomeProduto = '';
  String _descricao = '';
  String _preco = '';
  String _quantidade = '';
  bool _formEnviado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Campo Nome do Produto
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome do Produto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do produto';
                  } else if (value.length < 5) {
                    return 'O nome deve ter pelo menos 5 caracteres';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nomeProduto = value!;
                },
              ),
              // Campo Descrição
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição do produto';
                  } else if (value.length < 10) {
                    return 'A descrição deve ter pelo menos 10 caracteres';
                  }
                  return null;
                },
                onSaved: (value) {
                  _descricao = value!;
                },
              ),
              // Campo Preço
              TextFormField(
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o preço do produto';
                  } else if (double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'O preço deve ser um número maior que zero';
                  }
                  return null;
                },
                onSaved: (value) {
                  _preco = value!;
                },
              ),
              // Campo Quantidade em Estoque
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quantidade em Estoque'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a quantidade em estoque';
                  } else if (int.tryParse(value) == null || int.parse(value) < 0) {
                    return 'A quantidade deve ser um número inteiro positivo';
                  }
                  return null;
                },
                onSaved: (value) {
                  _quantidade = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _formKey.currentState!.save();
                      _formEnviado = true;
                    });
                  }
                },
                child: const Text('Salvar'),
              ),
              const SizedBox(height: 20),
              // Exibição de mensagem de sucesso
              if (_formEnviado)
                Text(
                  'Produto $_nomeProduto cadastrado com sucesso!',
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
