import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/report_viewmodel.dart';
import '../widgets/app_drawer.dart';

class ReportAccountScreen extends StatelessWidget {
  const ReportAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportViewModel(),
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text('Denunciar cuenta mancomunada'),
          backgroundColor: Colors.green,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: ReportForm(),
        ),
      ),
    );
  }
}

class ReportForm extends StatelessWidget {
  const ReportForm({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ReportViewModel>(context);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFCF5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Seleccione cuenta a denunciar'),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              value: vm.selectedAccount.isEmpty ? null : vm.selectedAccount,
              items: const [
                DropdownMenuItem(value: '123', child: Text('Cuenta 123')),
                DropdownMenuItem(value: '456', child: Text('Cuenta 456')),
              ],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: vm.updateAccount,
            ),
            const SizedBox(height: 20),

            const Text('Motivo de denuncia'),
            const SizedBox(height: 5),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Ej. La descripción no va con el fin de la cuenta mancomunada',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: vm.updateReason,
            ),
            const SizedBox(height: 20),

            const Text('Adjuntar evidencia'),
            const SizedBox(height: 5),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Seleccione hasta 3 archivos',
                suffixIcon: const Icon(Icons.upload_file),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () {
                // Simular selección
                vm.addEvidence('evidencia1.png');
              },
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  vm.submitReport();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reporte enviado')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFDFAE),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Denunciar cuenta mancomunada',
                  style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
