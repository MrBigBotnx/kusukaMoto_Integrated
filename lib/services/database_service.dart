import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kusuka_moto/models/agendamento.dart';
import 'package:kusuka_moto/models/pagamento.dart';
import 'package:kusuka_moto/models/servico.dart';
import 'package:kusuka_moto/models/usuario.dart';


class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Funções para a classe Usuario
  Future<void> addUser(Usuario usuario) async {
  await _db.collection('usuarios').doc(usuario.id).set(usuario.toMap());
}

  Stream<Usuario> getUser(String userId) {
  return _db.collection('usuarios').doc(userId).snapshots().map((snapshot) {
    return Usuario.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
  });
}

  Future<void> addService(Servico servico) async {
    await _db.collection('servicos').doc(servico.id).set(servico.toMap());
  }

  Stream<Servico> getService(String serviceId) {
    return _db.collection('servicos').doc(serviceId).snapshots().map((snapshot) {
      return Servico.fromMap(snapshot.data() as Map<String, dynamic>);
    });
  }

  // Métodos para Pagamento
  Future<void> addPagamento(Pagamento pagamento) async {
    await _db.collection('pagamentos').doc(pagamento.id).set(pagamento.toMap());
  }

  Stream<Pagamento> getPagamento(String pagamentoId) {
    return _db.collection('pagamentos').doc(pagamentoId).snapshots().map((snapshot) {
      return Pagamento.fromMap(snapshot.data() as Map<String, dynamic>);
    });
  }

  // Métodos para Agendamento
  Future<void> addAgendamento(Agendamento agendamento) async {
    await _db.collection('agendamentos').doc(agendamento.id).set(agendamento.toMap());
  }

  Stream<Agendamento> getAgendamento(String agendamentoId) {
    return _db.collection('agendamentos').doc(agendamentoId).snapshots().map((snapshot) {
      return Agendamento.fromMap(snapshot.data() as Map<String, dynamic>);
    });
  }
  
}
