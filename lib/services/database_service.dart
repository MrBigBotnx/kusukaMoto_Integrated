import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kusuka_moto/models/agendamento.dart';
import 'package:kusuka_moto/models/pagamento.dart';
import 'package:kusuka_moto/models/servico.dart';
import 'package:kusuka_moto/models/usuario.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage =
      FirebaseStorage.instance; // Instância do Firebase Storage

  Future<String?> uploadIcon(File icon) async {
    try {
      // Gera um ID único para o arquivo usando o UUID
      final String iconId = Uuid().v4();
      // Define o caminho onde o arquivo será salvo no Firebase Storage
      final Reference storageRef = _storage.ref().child('icons/$iconId');

      // Faz o upload do arquivo
      final UploadTask uploadTask = storageRef.putFile(icon);

      // Aguarda o upload ser concluído e obtém a URL de download
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl; // Retorna a URL do ícone no Firebase Storage
    } catch (e) {
      throw Exception('Erro ao fazer upload do ícone: $e');
    }
  }

  // Funções para a classe Usuario
  Future<void> addUser(Usuario usuario) async {
    await _db.collection('usuarios').doc(usuario.id).set(usuario.toMap());
  }

  Stream<Usuario> getUser(String userId) {
    return _db.collection('usuarios').doc(userId).snapshots().map((snapshot) {
      return Usuario.fromMap(
          snapshot.data() as Map<String, dynamic>, snapshot.id);
    });
  }

  // Funções para a classe Servico - adicionadas pelo admin
  Future<void> addService(Servico servico) async {
    await _db.collection('servicos').doc(servico.id).set(servico.toMap());
  }

  Future<void> updateService(Servico servico) async {
    await _db.collection('servicos').doc(servico.id).update(servico.toMap());
  }

  Future<void> deleteService(String serviceId) async {
    await _db.collection('servicos').doc(serviceId).delete();
  }

  // Adicione isso na DatabaseService
  Future<Servico?> getServiceById(String serviceId) async {
    try {
      final docSnapshot = await _db.collection('servicos').doc(serviceId).get();
      if (docSnapshot.exists) {
        return Servico.fromMap(docSnapshot.data() as Map<String, dynamic>);
      }
      return null; // Retorna nulo se o serviço não for encontrado
    } catch (e) {
      throw Exception('Erro ao buscar serviço: $e');
    }
  }

  // Apenas serviços disponíveis para o cliente
  Stream<List<Servico>> getAvailableServices() {
    return _db
        .collection('servicos')
        .where('disponibilidade', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            // ignore: unnecessary_cast
            .map((doc) => Servico.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  // Funções para manipular dados de Pagamento
  Future<void> addPagamento(Pagamento pagamento) async {
    await _db.collection('pagamentos').doc(pagamento.id).set(pagamento.toMap());
  }

  Stream<Pagamento> getPagamento(String pagamentoId) {
    return _db
        .collection('pagamentos')
        .doc(pagamentoId)
        .snapshots()
        .map((snapshot) {
      return Pagamento.fromMap(snapshot.data() as Map<String, dynamic>);
    });
  }

  // Funções para Agendamento
  Future<void> addAgendamento(Agendamento agendamento) async {
    await _db
        .collection('agendamentos')
        .doc(agendamento.id)
        .set(agendamento.toMap());
  }

  Stream<Agendamento> getAgendamento(String agendamentoId) {
    return _db
        .collection('agendamentos')
        .doc(agendamentoId)
        .snapshots()
        .map((snapshot) {
      return Agendamento.fromMap(snapshot.data() as Map<String, dynamic>);
    });
  }
}
