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
      home: const ProductFormStylized(), // Usando a tela estilizada
    );
  }
}

class ProductFormStylized extends StatefulWidget {
  const ProductFormStylized({super.key});

  @override
  _ProductFormStylizedState createState() => _ProductFormStylizedState();
}

class _ProductFormStylizedState extends State<ProductFormStylized> {
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
        title: const Text('Cadastro de Produto Estilizado'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Cadastrar Produto',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),
                // Campo Nome do Produto
                _buildTextField(
                  label: 'Nome do Produto',
                  hintText: 'Digite o nome do produto',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do produto';
                    } else if (value.length < 5) {
                      return 'O nome deve ter pelo menos 5 caracteres';
                    }
                    return null;
                  },
                  onSaved: (value) => _nomeProduto = value!,
                ),
                const SizedBox(height: 16),
                // Campo Descrição
                _buildTextField(
                  label: 'Descrição',
                  hintText: 'Descreva o produto',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a descrição do produto';
                    } else if (value.length < 10) {
                      return 'A descrição deve ter pelo menos 10 caracteres';
                    }
                    return null;
                  },
                  onSaved: (value) => _descricao = value!,
                ),
                const SizedBox(height: 16),
                // Campo Preço
                _buildTextField(
                  label: 'Preço',
                  hintText: 'Digite o preço',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o preço do produto';
                    } else if (double.tryParse(value) == null || double.parse(value) <= 0) {
                      return 'O preço deve ser um número maior que zero';
                    }
                    return null;
                  },
                  onSaved: (value) => _preco = value!,
                ),
                const SizedBox(height: 16),
                // Campo Quantidade em Estoque
                _buildTextField(
                  label: 'Quantidade em Estoque',
                  hintText: 'Digite a quantidade disponível',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a quantidade em estoque';
                    } else if (int.tryParse(value) == null || int.parse(value) < 0) {
                      return 'A quantidade deve ser um número inteiro positivo';
                    }
                    return null;
                  },
                  onSaved: (value) => _quantidade = value!,
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _formKey.currentState!.save();
                          _formEnviado = true;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple, // Cor de fundo do botão
                      foregroundColor: Colors.black, // Cor do texto do botão alterada para preto
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 16.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Salvar'),
                  ),
                ),
                const SizedBox(height: 20),
                // Exibição de mensagem de sucesso
                if (_formEnviado)
                  Center(
                    child: Text(
                      'Produto $_nomeProduto cadastrado com sucesso!',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget Helper para criar os campos de texto
  Widget _buildTextField({
    required String label,
    required String hintText,
    required FormFieldValidator<String> validator,
    required FormFieldSetter<String> onSaved,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
