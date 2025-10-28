import 'package:flutter/foundation.dart';
import 'package:apolo_project/models/lead.dart';
import 'package:apolo_project/models/customer.dart';
import 'package:apolo_project/models/user.dart';

class AppState extends ChangeNotifier {
  final List<Lead> _leads = Lead.dummyList();
  final List<Customer> _customers = Customer.dummyList();
  final List<User> _users = User.dummyList();

  List<Lead> get leads => _leads;
  List<Customer> get customers => _customers;
  List<User> get users => _users;

  void addLead(Lead lead) {
    _leads.add(lead.copyWith(id: _leads.length + 1));
    notifyListeners();
  }

  void updateLead(Lead lead) {
    final index = _leads.indexWhere((l) => l.id == lead.id);
    if (index != -1) {
      _leads[index] = lead;
      notifyListeners();
    }
  }

  void qualifyLeadAsCustomer(Lead lead) {
    final customer = Customer(
      id: _customers.length + 1,
      name: lead.name,
      phone: lead.phone,
      register: 'CLI${DateTime.now().millisecondsSinceEpoch}',
      location: lead.city ?? 'São Paulo, SP',
      date: DateTime.now(),
      lgpd: true,
      email: lead.email ?? '',
      enterprise: lead.enterprise,
      latitude: lead.latitude,
      longitude: lead.longitude,
    );
    _customers.add(customer);
    _leads.remove(lead);
    notifyListeners();
  }

  void addCustomer(Customer customer) {
    _customers.add(customer.copyWith(id: _customers.length + 1));
    notifyListeners();
  }

  void updateCustomer(Customer customer) {
    final index = _customers.indexWhere((c) => c.id == customer.id);
    if (index != -1) {
      _customers[index] = customer;
      notifyListeners();
    }
  }

  void addUser(User user) {
    _users.add(user.copyWith(id: _users.length + 1));
    notifyListeners();
  }

  void updateUser(User user) {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
      notifyListeners();
    }
  }
}