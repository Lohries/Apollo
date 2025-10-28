// lib/models/opportunity.dart
import 'package:apolo_project/models/negotiation_step.dart'; // IMPORT OBRIGATÓRIO

class Opportunity {
  int id;
  String clientInfo;
  String products;
  String bankingConditions;
  String contractSerial;
  String xmlAttachment;
  String negotiationPhoto;

  Opportunity({
    required this.id,
    required this.clientInfo,
    required this.products,
    required this.bankingConditions,
    required this.contractSerial,
    required this.xmlAttachment,
    required this.negotiationPhoto,
  });

  static List<NegotiationStep> defaultTemplate() {
    return [
      NegotiationStep(
        name: '1. Info do Cliente',
        fields: [
          NegotiationField(label: 'Nome do Cliente', required: true, type: 'text'),
          NegotiationField(label: 'Email do Cliente', required: true, type: 'text'),
          NegotiationField(label: 'Telefone do Cliente', required: true, type: 'text'),
        ],
      ),
      NegotiationStep(
        name: '2. Definição dos Produtos',
        fields: [
          NegotiationField(label: 'Lista de Produtos', required: true, type: 'text'),
          NegotiationField(label: 'Quantidade', required: true, type: 'number'),
          NegotiationField(label: 'Preço por Unidade', required: true, type: 'number'),
        ],
      ),
      NegotiationStep(
        name: '3. Condições Bancárias',
        fields: [
          NegotiationField(
            label: 'Forma de Pagamento',
            required: true,
            type: 'select',
            options: ['Boleto', 'Cartão', 'Transferência', 'Pix'],
          ),
          NegotiationField(label: 'Prazo de Pagamento', required: true, type: 'number'),
          NegotiationField(label: 'Valor Total', required: true, type: 'number'),
        ],
      ),
      NegotiationStep(
        name: '4. Contrato e Número de Série do Produto',
        fields: [
          NegotiationField(label: 'Número do Contrato', required: true, type: 'text'),
          NegotiationField(label: 'Número de Série do Produto', required: true, type: 'text'),
          NegotiationField(label: 'Data de Assinatura', required: true, type: 'date'),
        ],
      ),
      NegotiationStep(
        name: '5. Anexo da XML e Foto da Negociação',
        fields: [
          NegotiationField(label: 'Anexo XML', required: true, type: 'file'),
          NegotiationField(label: 'Foto da Negociação', required: false, type: 'file'),
          NegotiationField(label: 'Observações Finais', required: false, type: 'text'),
        ],
      ),
    ];
  }
}