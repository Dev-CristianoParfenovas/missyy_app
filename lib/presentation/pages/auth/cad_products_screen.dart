import 'package:flutter/material.dart';
import 'package:missyy/domain/models/product_manager.dart';
import 'package:missyy/presentation/widgets/components/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../../../_core/screen_colors.dart';

class CadProducts extends StatelessWidget {
  CadProducts({super.key});

  final formKey = GlobalKey<FormState>();

  final ProductManager productManager = ProductManager();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ScreenColors.corPadraoApp,
        elevation: 0,
        toolbarHeight: 72,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Cadastrar Produtos',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 50,
          ),
          child: Form(
            key: formKey,
            child: Consumer<ProductManager>(builder: (_, productManager, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    controller: nameController,
                    icon: Icons.add_home,
                    label: 'Nome do Produto',
                    validator: (name) {
                      if (name!.isEmpty) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                    // onSaved: (name) => userLogin.name = name,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomTextField(
                    controller: priceController,
                    icon: Icons.price_change,
                    label: 'Valor do Produto',
                    validator: (price) {
                      if (price!.isEmpty) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                    // onSaved: (name) => userLogin.name = name,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CustomTextField(
                    controller: descriptionController,
                    icon: Icons.add_box,

                    label: 'Descrição do Produto',
                    validator: (descr) {
                      if (descr!.isEmpty) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                    // onSaved: (name) => userLogin.name = name,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
