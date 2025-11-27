// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt';

  static String m0(msg) => "${msg} Todos os direitos reservados.";

  static String m1(msg) => "Tem certeza de que deseja ${msg} do aplicativo";

  static String m2(msg) => "Erro: ${msg}";

  static String m3(length) => "Deve ter pelo menos ${length} caracteres";

  static String m4(secondsRemaining) =>
      "Reenviar código em 00:${secondsRemaining}";

  static String m5(length) =>
      "Use pelo menos ${length} caracteres com letras, números e símbolos.";

  static String m6(method) =>
      "Pago via ${method}. Esperamos que tenha tido uma ótima viagem! Não se esqueça de deixar uma avaliação.";

  static String m7(amount) =>
      "Sucesso! Você solicitou ${amount} de saque. Os fundos serão transferidos para sua conta em breve.";

  static String m8(msg) => "Escreva ${msg}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accept_ride": MessageLookupByLibrary.simpleMessage("Aceitar Corrida"),
    "account": MessageLookupByLibrary.simpleMessage("Conta"),
    "activity": MessageLookupByLibrary.simpleMessage("Atividade"),
    "add_balance_to_your_wallet": MessageLookupByLibrary.simpleMessage(
      "Adicionar saldo à sua carteira",
    ),
    "add_driver_documents": MessageLookupByLibrary.simpleMessage(
      "Adicionar documentos do motorista",
    ),
    "add_driver_personal_info": MessageLookupByLibrary.simpleMessage(
      "Adicionar informações pessoais do motorista",
    ),
    "add_legal_documents": MessageLookupByLibrary.simpleMessage(
      "Adicionar Documentos Legais",
    ),
    "add_new": MessageLookupByLibrary.simpleMessage("Adicionar novo"),
    "add_payment_gateway": MessageLookupByLibrary.simpleMessage(
      "Adicionar Gateway de Pagamento",
    ),
    "add_wallet": MessageLookupByLibrary.simpleMessage("Adicionar à Carteira"),
    "address": MessageLookupByLibrary.simpleMessage("Endereço"),
    "all_field_required": MessageLookupByLibrary.simpleMessage(
      "Todos os campos são obrigatórios",
    ),
    "all_rights_reserved": m0,
    "all_set_start_ride": MessageLookupByLibrary.simpleMessage(
      "Tudo Pronto? Comece a Corrida Agora",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Permitir"),
    "already_have_account": MessageLookupByLibrary.simpleMessage(
      "Já tem uma conta?",
    ),
    "amount": MessageLookupByLibrary.simpleMessage("Valor"),
    "and": MessageLookupByLibrary.simpleMessage("e"),
    "app_encountered_unexpected_error": MessageLookupByLibrary.simpleMessage(
      "O aplicativo encontrou um erro inesperado e precisou ser fechado. Isso pode ser causado por memória insuficiente, um bug no app ou um arquivo corrompido. Reinicie o app ou reinstale se o problema continuar.",
    ),
    "apply": MessageLookupByLibrary.simpleMessage("Aplicar"),
    "are_you_sure_msg": m1,
    "arrived_pickup_point": MessageLookupByLibrary.simpleMessage(
      "Você Chegou ao Ponto de Pickup",
    ),
    "average_rating": MessageLookupByLibrary.simpleMessage("Avaliação Média"),
    "back": MessageLookupByLibrary.simpleMessage("Voltar"),
    "bad_certificate_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Certificado inválido com o servidor API",
    ),
    "bad_request": MessageLookupByLibrary.simpleMessage("Solicitação inválida"),
    "button": MessageLookupByLibrary.simpleMessage("Botão"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cancel_ride": MessageLookupByLibrary.simpleMessage("Cancelar viagem"),
    "cancel_subtitle": MessageLookupByLibrary.simpleMessage(
      "Informe-nos o motivo do cancelamento da viagem.",
    ),
    "cancel_the_ride": MessageLookupByLibrary.simpleMessage(
      "Cancelar a viagem",
    ),
    "cancel_title": MessageLookupByLibrary.simpleMessage(
      "Conte-nos por que você está cancelando a viagem",
    ),
    "card_number": MessageLookupByLibrary.simpleMessage("Número do Cartão"),
    "cardholder_name": MessageLookupByLibrary.simpleMessage(
      "Nome do Titular do Cartão",
    ),
    "change_password": MessageLookupByLibrary.simpleMessage("Alterar senha"),
    "citizen_card": MessageLookupByLibrary.simpleMessage("Cartão de Cidadão"),
    "close": MessageLookupByLibrary.simpleMessage("FECHAR"),
    "complete_ride": MessageLookupByLibrary.simpleMessage("Concluir viagem"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
    "confirm_new_password": MessageLookupByLibrary.simpleMessage(
      "Confirme a Nova Senha",
    ),
    "confirm_password": MessageLookupByLibrary.simpleMessage("Confirmar senha"),
    "confirm_pay": MessageLookupByLibrary.simpleMessage("Confirmar Pagamento"),
    "confirm_pickup": MessageLookupByLibrary.simpleMessage("Confirmar Pickup"),
    "connection_error_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Erro de conexão com o servidor API",
    ),
    "connection_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Tempo de conexão esgotado com o servidor API",
    ),
    "contact_support": MessageLookupByLibrary.simpleMessage("Contatar Suporte"),
    "country": MessageLookupByLibrary.simpleMessage("País"),
    "criminal_record_certificate": MessageLookupByLibrary.simpleMessage(
      "Certificado de Registo Criminal",
    ),
    "current_balance": MessageLookupByLibrary.simpleMessage("Saldo Atual"),
    "current_password": MessageLookupByLibrary.simpleMessage("Senha Atual"),
    "cvv": MessageLookupByLibrary.simpleMessage("CVV"),
    "date_of_birth": MessageLookupByLibrary.simpleMessage("Data de nascimento"),
    "delete": MessageLookupByLibrary.simpleMessage("Excluir"),
    "delete_account": MessageLookupByLibrary.simpleMessage("Deletar Conta"),
    "delete_account_confirmation": MessageLookupByLibrary.simpleMessage(
      "Tem certeza de que deseja excluir sua conta?",
    ),
    "delete_account_warning": MessageLookupByLibrary.simpleMessage(
      "Esta ação é permanente e não pode ser desfeita.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Destino"),
    "details": MessageLookupByLibrary.simpleMessage("Detalhes"),
    "didnt_receive_code": MessageLookupByLibrary.simpleMessage(
      "Não recebeu o código?",
    ),
    "discount": MessageLookupByLibrary.simpleMessage("Desconto"),
    "double_check_rider": MessageLookupByLibrary.simpleMessage(
      "Verifique o nome do passageiro e confirme o destino antes de prosseguir.",
    ),
    "double_tap_create_account": MessageLookupByLibrary.simpleMessage(
      "Toque duas vezes para criar sua conta",
    ),
    "driver_documents": MessageLookupByLibrary.simpleMessage(
      "Documentos do motorista",
    ),
    "driving_license": MessageLookupByLibrary.simpleMessage(
      "Carteira de motorista",
    ),
    "driving_license_required": MessageLookupByLibrary.simpleMessage(
      "Carteira de motorista é obrigatória",
    ),
    "either_phone_number_is_null_or_password_is_empty":
        MessageLookupByLibrary.simpleMessage(
          "O número de telefone é nulo ou a senha está vazia",
        ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "email_label": MessageLookupByLibrary.simpleMessage("Email"),
    "email_or_phone": MessageLookupByLibrary.simpleMessage(
      "E-mail ou número de telefone",
    ),
    "email_or_phone_required": MessageLookupByLibrary.simpleMessage(
      "E-mail ou número de telefone obrigatório",
    ),
    "emergency_phone": MessageLookupByLibrary.simpleMessage(
      "Telefone de emergência",
    ),
    "enterPhoneDes": MessageLookupByLibrary.simpleMessage(
      "Digite seu número de telefone para continuar sua viagem e ficar atualizado.",
    ),
    "enterPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Digite o número de telefone",
    ),
    "enter_3_digit_cvv": MessageLookupByLibrary.simpleMessage(
      "Digite o CVV de 3 dígitos",
    ),
    "enter_a_valid_amount": MessageLookupByLibrary.simpleMessage(
      "Digite um valor válido",
    ),
    "enter_amount": MessageLookupByLibrary.simpleMessage("Digite o Valor"),
    "enter_cardholder_name": MessageLookupByLibrary.simpleMessage(
      "Digite o nome do titular do cartão",
    ),
    "enter_details_complete_profile": MessageLookupByLibrary.simpleMessage(
      "Insira seus dados para completar seu perfil e melhorar sua experiência.",
    ),
    "enter_experience": MessageLookupByLibrary.simpleMessage(
      "Digite Sua Experiência!",
    ),
    "enter_legal_documents_to_complete_profile":
        MessageLookupByLibrary.simpleMessage(
          "Introduza os documentos legais para completar o perfil",
        ),
    "enter_otp_code": MessageLookupByLibrary.simpleMessage(
      "Insira seu código OTP",
    ),
    "enter_otp_fields": MessageLookupByLibrary.simpleMessage(
      "Insira os campos do OTP",
    ),
    "enter_otp_in_fields": MessageLookupByLibrary.simpleMessage(
      "Digite o OTP nos campos",
    ),
    "enter_password": MessageLookupByLibrary.simpleMessage("Digite sua Senha"),
    "enter_password_description": MessageLookupByLibrary.simpleMessage(
      "Por favor, digite a senha da sua conta para continuar.",
    ),
    "enter_plate_number": MessageLookupByLibrary.simpleMessage(
      "Digite o número da placa",
    ),
    "enter_valid_card_number": MessageLookupByLibrary.simpleMessage(
      "Digite um número de cartão válido",
    ),
    "enter_valid_email_or_phone": MessageLookupByLibrary.simpleMessage(
      "Digite um e-mail ou número de telefone válido",
    ),
    "enter_vehicle_name": MessageLookupByLibrary.simpleMessage(
      "Digite o nome do veículo",
    ),
    "enter_your_password": MessageLookupByLibrary.simpleMessage(
      "Digite sua senha",
    ),
    "error_with_msg": m2,
    "estimated_time": MessageLookupByLibrary.simpleMessage("Tempo estimado"),
    "exit": MessageLookupByLibrary.simpleMessage("Sair"),
    "exp_date": MessageLookupByLibrary.simpleMessage("Data de Validade"),
    "expiryDate": MessageLookupByLibrary.simpleMessage("Data de Expiração"),
    "female": MessageLookupByLibrary.simpleMessage("Feminino"),
    "field_required": MessageLookupByLibrary.simpleMessage(
      "Este campo é obrigatório",
    ),
    "find_you_faster": MessageLookupByLibrary.simpleMessage(
      "Vamos encontrá-lo mais rápido!",
    ),
    "find_you_faster_msg": MessageLookupByLibrary.simpleMessage(
      "Ative o acesso à localização para encontrar motoristas próximos de forma rápida e fácil.",
    ),
    "first_name": MessageLookupByLibrary.simpleMessage("Primeiro nome"),
    "follow_directions_comfortable": MessageLookupByLibrary.simpleMessage(
      "Siga as instruções, mantenha a calma e proporcione um ambiente de viagem confortável.",
    ),
    "forbidden_access_please_login_again": MessageLookupByLibrary.simpleMessage(
      "Acesso proibido. Por favor, faça login novamente.",
    ),
    "forget_password": MessageLookupByLibrary.simpleMessage(
      "Esqueceu a senha?",
    ),
    "form_is_not_valid": MessageLookupByLibrary.simpleMessage(
      "O formulário não é válido",
    ),
    "full_name": MessageLookupByLibrary.simpleMessage("Nome Completo"),
    "gender": MessageLookupByLibrary.simpleMessage("Gênero"),
    "gender_female": MessageLookupByLibrary.simpleMessage("Feminino"),
    "gender_label": MessageLookupByLibrary.simpleMessage("Gênero"),
    "gender_male": MessageLookupByLibrary.simpleMessage("Masculino"),
    "gender_other": MessageLookupByLibrary.simpleMessage("Outro"),
    "gender_required": MessageLookupByLibrary.simpleMessage(
      "Gênero é obrigatório",
    ),
    "gender_select": MessageLookupByLibrary.simpleMessage("Selecione o gênero"),
    "go_back_to_ride": MessageLookupByLibrary.simpleMessage("Voltar à viagem"),
    "go_to_pickup_location": MessageLookupByLibrary.simpleMessage(
      "Ir para o Local de Pickup",
    ),
    "grant_permission": MessageLookupByLibrary.simpleMessage(
      "Conceder Permissão",
    ),
    "helloText": MessageLookupByLibrary.simpleMessage("Olá..."),
    "home": MessageLookupByLibrary.simpleMessage("Início"),
    "id": MessageLookupByLibrary.simpleMessage("ID: "),
    "initializing": MessageLookupByLibrary.simpleMessage("Inicializando..."),
    "insertAllData": MessageLookupByLibrary.simpleMessage(
      "Por favor, insira todos os dados",
    ),
    "internal_server_error": MessageLookupByLibrary.simpleMessage(
      "Erro interno do servidor",
    ),
    "issueSubmitted": MessageLookupByLibrary.simpleMessage(
      "Seu Problema foi Enviado com Sucesso",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "last_name": MessageLookupByLibrary.simpleMessage("Sobrenome"),
    "legal_documents": MessageLookupByLibrary.simpleMessage(
      "Documentos Legais",
    ),
    "lets_ride": MessageLookupByLibrary.simpleMessage("Vamos Rodar"),
    "location": MessageLookupByLibrary.simpleMessage("Localização"),
    "location_permission_msg": MessageLookupByLibrary.simpleMessage(
      "Por favor, habilite o acesso à localização para usar este recurso.",
    ),
    "location_permission_needed": MessageLookupByLibrary.simpleMessage(
      "Permissão de Localização Necessária",
    ),
    "log_out": MessageLookupByLibrary.simpleMessage("Sair"),
    "loggingInSomewhereElse": MessageLookupByLibrary.simpleMessage(
      "Conectando-se em Outro Dispositivo",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Entrar"),
    "loginSignup": MessageLookupByLibrary.simpleMessage("Entrar / Cadastrar"),
    "login_with_your_password": MessageLookupByLibrary.simpleMessage(
      "Entrar com sua Senha",
    ),
    "male": MessageLookupByLibrary.simpleMessage("Masculino"),
    "method": MessageLookupByLibrary.simpleMessage("Método: "),
    "min_length_error": m3,
    "mobile_number": MessageLookupByLibrary.simpleMessage("Número de Celular"),
    "my_profile": MessageLookupByLibrary.simpleMessage("Meu Perfil"),
    "name_label": MessageLookupByLibrary.simpleMessage("Nome"),
    "nationality": MessageLookupByLibrary.simpleMessage("Nacionalidade"),
    "new_password": MessageLookupByLibrary.simpleMessage("Nova Senha"),
    "next": MessageLookupByLibrary.simpleMessage("Próximo"),
    "nid_image_required": MessageLookupByLibrary.simpleMessage(
      "Imagem do NID é obrigatória",
    ),
    "nid_photo": MessageLookupByLibrary.simpleMessage("Foto do NID"),
    "no_address_found": MessageLookupByLibrary.simpleMessage(
      "Nenhum endereço encontrado",
    ),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage(
      "Nenhum cartão ainda!",
    ),
    "no_internet_connection": MessageLookupByLibrary.simpleMessage(
      "Sem conexão com a internet.",
    ),
    "no_internet_connection_please_check": MessageLookupByLibrary.simpleMessage(
      "Sem conexão com a internet. Por favor, verifique sua conexão.",
    ),
    "no_payment_methods_available": MessageLookupByLibrary.simpleMessage(
      "Nenhum método de pagamento disponível",
    ),
    "no_rides_yet": MessageLookupByLibrary.simpleMessage(
      "Nenhuma viagem ainda.",
    ),
    "no_service_available": MessageLookupByLibrary.simpleMessage(
      "Nenhum serviço disponível",
    ),
    "no_transactions_found": MessageLookupByLibrary.simpleMessage(
      "Nenhuma transação encontrada",
    ),
    "no_wallet_data_available": MessageLookupByLibrary.simpleMessage(
      "Nenhum dado da carteira disponível",
    ),
    "offline": MessageLookupByLibrary.simpleMessage("Offline"),
    "or": MessageLookupByLibrary.simpleMessage("ou"),
    "or_select_avatar": MessageLookupByLibrary.simpleMessage(
      "Ou selecione um avatar da lista abaixo:",
    ),
    "other": MessageLookupByLibrary.simpleMessage("Outro"),
    "otp_enter_title": MessageLookupByLibrary.simpleMessage("Digite seu OTP"),
    "otp_input_hint": MessageLookupByLibrary.simpleMessage("Escreva seu OTP"),
    "otp_resend": MessageLookupByLibrary.simpleMessage("Reenviar"),
    "otp_resend_button": MessageLookupByLibrary.simpleMessage(
      "Botão de reenviar OTP",
    ),
    "otp_resend_timer": m4,
    "otp_save_button": MessageLookupByLibrary.simpleMessage("Salvar"),
    "otp_sent_message": MessageLookupByLibrary.simpleMessage(
      "Enviamos o código OTP para si",
    ),
    "otp_title_short": MessageLookupByLibrary.simpleMessage("OTP"),
    "otp_verify_button": MessageLookupByLibrary.simpleMessage(
      "Botão de verificação de OTP",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Senha"),
    "password_hint": MessageLookupByLibrary.simpleMessage(
      "Defina uma senha forte",
    ),
    "password_label": MessageLookupByLibrary.simpleMessage("Senha"),
    "password_mismatch": MessageLookupByLibrary.simpleMessage(
      "As senhas não coincidem.",
    ),
    "password_requirements": m5,
    "payment_completed": MessageLookupByLibrary.simpleMessage(
      "Obrigado! Pagamento concluído",
    ),
    "payment_confirmation": m6,
    "payment_gateway": MessageLookupByLibrary.simpleMessage(
      "Gateway de Pagamento",
    ),
    "payment_received": MessageLookupByLibrary.simpleMessage(
      "Pagamento Recebido",
    ),
    "payment_withdraw": MessageLookupByLibrary.simpleMessage(
      "Saque de Pagamento",
    ),
    "payout_method": MessageLookupByLibrary.simpleMessage(
      "Método de Pagamento",
    ),
    "personal_info": MessageLookupByLibrary.simpleMessage(
      "Informações Pessoais",
    ),
    "phoneMinLengthError": MessageLookupByLibrary.simpleMessage(
      "O número de telefone deve ter pelo menos 6 dígitos",
    ),
    "phoneNo": MessageLookupByLibrary.simpleMessage("Número de telefone"),
    "phone_verification": MessageLookupByLibrary.simpleMessage(
      "Verificação do telefone",
    ),
    "pick_a_date": MessageLookupByLibrary.simpleMessage("Escolha uma data"),
    "pickup": MessageLookupByLibrary.simpleMessage("Embarque"),
    "pickup_rider": MessageLookupByLibrary.simpleMessage("Pegar Passageiro"),
    "plate_number": MessageLookupByLibrary.simpleMessage("Número da placa"),
    "please_enter_amount": MessageLookupByLibrary.simpleMessage(
      "Por favor, digite o valor",
    ),
    "please_select_payment_type": MessageLookupByLibrary.simpleMessage(
      "Por favor, selecione o tipo de pagamento",
    ),
    "please_wait": MessageLookupByLibrary.simpleMessage(
      "Por favor, aguarde...",
    ),
    "privacy_policy": MessageLookupByLibrary.simpleMessage(
      "Política de Privacidade",
    ),
    "production_year": MessageLookupByLibrary.simpleMessage(
      "Ano de fabricação",
    ),
    "profile_image": MessageLookupByLibrary.simpleMessage("Imagem de perfil"),
    "profile_image_required": MessageLookupByLibrary.simpleMessage(
      "Imagem de perfil é obrigatória",
    ),
    "profile_submitted_reviewed": MessageLookupByLibrary.simpleMessage(
      "Seu perfil foi enviado e está sendo revisado. Você será notificado quando for aprovado.",
    ),
    "profile_under_review": MessageLookupByLibrary.simpleMessage(
      "Seu Perfil Está Sob Revisão",
    ),
    "reached_destination": MessageLookupByLibrary.simpleMessage(
      "Destino Atingido",
    ),
    "reached_passenger_destination": MessageLookupByLibrary.simpleMessage(
      "Você Chegou ao Destino do Passageiro.",
    ),
    "reached_pickup_wait": MessageLookupByLibrary.simpleMessage(
      "Você chegou ao local de pickup. Aguarde alguns minutos para o passageiro se aproximar do veículo.",
    ),
    "receive_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Tempo de recebimento esgotado com o servidor API",
    ),
    "received_invalid_response_from_server":
        MessageLookupByLibrary.simpleMessage(
          "Recebida uma resposta inválida do servidor.",
        ),
    "registration_done": MessageLookupByLibrary.simpleMessage(
      "Registro Concluído!",
    ),
    "registration_form_fields": MessageLookupByLibrary.simpleMessage(
      "Campos do formulário de registro",
    ),
    "registration_heading": MessageLookupByLibrary.simpleMessage(
      "Cabeçalho de registro",
    ),
    "reportIssue": MessageLookupByLibrary.simpleMessage("Reportar Problema"),
    "reportIssueSubtitle": MessageLookupByLibrary.simpleMessage(
      "Conte-nos o que deu errado. Iremos analisar imediatamente.",
    ),
    "reportIssueTitle": MessageLookupByLibrary.simpleMessage(
      "Algo deu errado? Reporte um Problema",
    ),
    "reportType": MessageLookupByLibrary.simpleMessage("Tipo de Relatório"),
    "requestEntityTooLarge": MessageLookupByLibrary.simpleMessage(
      "Entidade da Solicitação Muito Grande",
    ),
    "request_timed_out_please_try_again": MessageLookupByLibrary.simpleMessage(
      "Tempo de solicitação esgotado. Por favor, tente novamente.",
    ),
    "request_to_api_server_was_cancelled": MessageLookupByLibrary.simpleMessage(
      "Solicitação ao servidor API foi cancelada",
    ),
    "resend_again": MessageLookupByLibrary.simpleMessage("Reenviar novamente"),
    "residence_permit_if_non_eu": MessageLookupByLibrary.simpleMessage(
      "Autorização de Residência (se não for da UE)",
    ),
    "resource_not_found": MessageLookupByLibrary.simpleMessage(
      "Recurso não encontrado.",
    ),
    "rideCharge": MessageLookupByLibrary.simpleMessage("Cobrança da Corrida"),
    "rideDetails": MessageLookupByLibrary.simpleMessage("Detalhes da Corrida"),
    "ride_complete": MessageLookupByLibrary.simpleMessage(
      "Sua viagem está concluída",
    ),
    "ride_feedback_prompt": MessageLookupByLibrary.simpleMessage(
      "Esperamos que você tenha tido uma viagem tranquila. Por favor, conclua o pagamento e avalie sua experiência.",
    ),
    "ride_history": MessageLookupByLibrary.simpleMessage(
      "Histórico de Viagens",
    ),
    "ride_preferences": MessageLookupByLibrary.simpleMessage(
      "Preferências de Viagem",
    ),
    "ride_preferences_description": MessageLookupByLibrary.simpleMessage(
      "Selecione o tipo de viagem que melhor atende às suas necessidades.",
    ),
    "ride_requested": MessageLookupByLibrary.simpleMessage("Viagem solicitada"),
    "rider_waiting_move_now": MessageLookupByLibrary.simpleMessage(
      "Passageiro Esperando — Mova-se Agora",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Salvar"),
    "searching_for_driver": MessageLookupByLibrary.simpleMessage(
      "Procurando por um motorista online...",
    ),
    "see_you_next_ride": MessageLookupByLibrary.simpleMessage(
      "Esperamos vê-lo novamente em sua próxima viagem!",
    ),
    "selectReportType": MessageLookupByLibrary.simpleMessage(
      "Selecione o Tipo de Relatório",
    ),
    "select_a_country": MessageLookupByLibrary.simpleMessage(
      "Selecione um país",
    ),
    "select_card_type": MessageLookupByLibrary.simpleMessage(
      "Selecione o tipo de cartão",
    ),
    "select_gender": MessageLookupByLibrary.simpleMessage("Selecionar gênero"),
    "select_payment_method": MessageLookupByLibrary.simpleMessage(
      "Selecione o método de pagamento",
    ),
    "select_pickup_location": MessageLookupByLibrary.simpleMessage(
      "Selecione o local de partida",
    ),
    "select_profile_image": MessageLookupByLibrary.simpleMessage(
      "Selecionar Imagem de Perfil",
    ),
    "select_service": MessageLookupByLibrary.simpleMessage(
      "Selecione um serviço!",
    ),
    "select_vehicle_color": MessageLookupByLibrary.simpleMessage(
      "Selecione a cor do veículo",
    ),
    "select_vehicle_type": MessageLookupByLibrary.simpleMessage(
      "Selecione o tipo de veículo",
    ),
    "send_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Tempo de envio esgotado com o servidor API",
    ),
    "service_charge": MessageLookupByLibrary.simpleMessage("Taxa de Serviço"),
    "share_experience": MessageLookupByLibrary.simpleMessage(
      "Compartilhe Sua Experiência!",
    ),
    "sign_in": MessageLookupByLibrary.simpleMessage("Entrar"),
    "sign_in_form_fields": MessageLookupByLibrary.simpleMessage(
      "Campos do formulário de login",
    ),
    "sign_in_heading": MessageLookupByLibrary.simpleMessage(
      "Cabeçalho de login",
    ),
    "sign_in_with_email_phone": MessageLookupByLibrary.simpleMessage(
      "Entre com seu e-mail ou número de telefone",
    ),
    "sign_up": MessageLookupByLibrary.simpleMessage("Cadastrar-se"),
    "sign_up_with_email_or_phone": MessageLookupByLibrary.simpleMessage(
      "Cadastre-se com seu e-mail ou número de telefone",
    ),
    "signup_with_apple": MessageLookupByLibrary.simpleMessage(
      "Cadastre-se com Apple",
    ),
    "signup_with_facebook": MessageLookupByLibrary.simpleMessage(
      "Cadastre-se com Facebook",
    ),
    "signup_with_gmail": MessageLookupByLibrary.simpleMessage(
      "Cadastre-se com Gmail",
    ),
    "skip_for_now": MessageLookupByLibrary.simpleMessage("Pular por agora"),
    "social_security_number": MessageLookupByLibrary.simpleMessage(
      "Número de Segurança Social",
    ),
    "something_went_wrong": MessageLookupByLibrary.simpleMessage(
      "Algo deu errado",
    ),
    "something_went_wrong_exclamation": MessageLookupByLibrary.simpleMessage(
      "Algo deu errado!",
    ),
    "start_journey_navigation": MessageLookupByLibrary.simpleMessage(
      "Inicie a viagem seguindo a navegação do app. Certifique-se de que ambas as partes estão confortáveis antes de começar.",
    ),
    "start_ride": MessageLookupByLibrary.simpleMessage("Iniciar viagem"),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "stayOnThisDevice": MessageLookupByLibrary.simpleMessage(
      "Permanecer neste Dispositivo",
    ),
    "stop_point": MessageLookupByLibrary.simpleMessage("Ponto de parada"),
    "submit": MessageLookupByLibrary.simpleMessage("Enviar"),
    "tap_to_confirm_arrival": MessageLookupByLibrary.simpleMessage(
      "Toque para Confirmar Sua Chegada",
    ),
    "tap_to_start_ride": MessageLookupByLibrary.simpleMessage(
      "Toque para Começar a Corrida",
    ),
    "tax_number": MessageLookupByLibrary.simpleMessage("Número fiscal"),
    "terms_agreement": MessageLookupByLibrary.simpleMessage(
      "Ao se cadastrar, você concorda com a",
    ),
    "terms_conditions": MessageLookupByLibrary.simpleMessage(
      "Termos e Condições",
    ),
    "terms_conditions_checkbox": MessageLookupByLibrary.simpleMessage(
      "Caixa de seleção de termos e condições e descrição",
    ),
    "terms_of_service": MessageLookupByLibrary.simpleMessage(
      "Termos de serviço",
    ),
    "textCopied": MessageLookupByLibrary.simpleMessage("Texto copiado"),
    "thanksForReporting": MessageLookupByLibrary.simpleMessage(
      "Obrigado por reportar. Nossa equipe analisará o problema e retornará em breve.",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "time_to_pickup": MessageLookupByLibrary.simpleMessage(
      "Hora de pegar seu passageiro! Siga a navegação e chegue sem atrasos",
    ),
    "tips_withdraw": MessageLookupByLibrary.simpleMessage(
      "Levantamento de gorjetas",
    ),
    "today": MessageLookupByLibrary.simpleMessage("Hoje"),
    "todays_activity": MessageLookupByLibrary.simpleMessage(
      "Atividade de Hoje",
    ),
    "todays_earning": MessageLookupByLibrary.simpleMessage("Ganhos de Hoje"),
    "top_up_your_wallet_securely_and_enjoy_seamless_payments":
        MessageLookupByLibrary.simpleMessage(
          "Recarregue sua carteira com segurança e aproveite pagamentos contínuos.",
        ),
    "total_amount": MessageLookupByLibrary.simpleMessage("Valor Total"),
    "total_distance": MessageLookupByLibrary.simpleMessage("Distância Total"),
    "total_rides": MessageLookupByLibrary.simpleMessage("Total de Corridas"),
    "transactions": MessageLookupByLibrary.simpleMessage("Transações"),
    "trip_ended_passenger_destination": MessageLookupByLibrary.simpleMessage(
      "A viagem terminou pois o passageiro chegou ao destino.",
    ),
    "trip_ended_wait_payment": MessageLookupByLibrary.simpleMessage(
      "A viagem terminou. Aguarde o passageiro completar o pagamento antes de encerrar a corrida.",
    ),
    "trips": MessageLookupByLibrary.simpleMessage("Viagens"),
    "tvde_driver_certificate": MessageLookupByLibrary.simpleMessage(
      "Certificado de Motorista TVDE",
    ),
    "type_a_message": MessageLookupByLibrary.simpleMessage(
      "Digite uma mensagem",
    ),
    "unauthorized_access_please_login_again":
        MessageLookupByLibrary.simpleMessage(
          "Acesso não autorizado. Por favor, faça login novamente.",
        ),
    "unexpected_application_crash": MessageLookupByLibrary.simpleMessage(
      "Falha inesperada do aplicativo",
    ),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Ocorreu um erro inesperado",
    ),
    "unexpected_response_format": MessageLookupByLibrary.simpleMessage(
      "Formato de resposta inesperado",
    ),
    "update": MessageLookupByLibrary.simpleMessage("Atualizar"),
    "upload": MessageLookupByLibrary.simpleMessage("Enviar"),
    "upload_back": MessageLookupByLibrary.simpleMessage("Carregar Verso"),
    "upload_driver_documents": MessageLookupByLibrary.simpleMessage(
      "Envie seus documentos do motorista para concluir a verificação e começar a dirigir. Rápido, fácil e seguro!",
    ),
    "upload_front": MessageLookupByLibrary.simpleMessage("Carregar Frente"),
    "upload_image": MessageLookupByLibrary.simpleMessage("Carregar imagem"),
    "use_otp_instead": MessageLookupByLibrary.simpleMessage(
      "Usar OTP em vez disso",
    ),
    "use_your_password_here": MessageLookupByLibrary.simpleMessage(
      "Use sua senha aqui",
    ),
    "validation_error": MessageLookupByLibrary.simpleMessage(
      "Erro de validação",
    ),
    "validator_email_invalid": MessageLookupByLibrary.simpleMessage(
      "Insira um e-mail válido",
    ),
    "validator_email_required": MessageLookupByLibrary.simpleMessage(
      "E-mail é obrigatório",
    ),
    "validator_name_invalid": MessageLookupByLibrary.simpleMessage(
      "Insira um nome válido",
    ),
    "validator_name_required": MessageLookupByLibrary.simpleMessage(
      "Nome é obrigatório",
    ),
    "validator_number_invalid": MessageLookupByLibrary.simpleMessage(
      "Insira um número válido",
    ),
    "validator_number_required": MessageLookupByLibrary.simpleMessage(
      "Número é obrigatório",
    ),
    "validator_password_required": MessageLookupByLibrary.simpleMessage(
      "Senha é obrigatória",
    ),
    "validator_password_too_short": MessageLookupByLibrary.simpleMessage(
      "A senha deve ter pelo menos 6 caracteres",
    ),
    "validator_phone_invalid": MessageLookupByLibrary.simpleMessage(
      "Insira um número de telefone válido",
    ),
    "validator_phone_required": MessageLookupByLibrary.simpleMessage(
      "Número de telefone é obrigatório",
    ),
    "vehicle_color": MessageLookupByLibrary.simpleMessage("Cor do veículo"),
    "vehicle_model": MessageLookupByLibrary.simpleMessage("Modelo do veículo"),
    "vehicle_model_name": MessageLookupByLibrary.simpleMessage(
      "Nome do modelo do veículo",
    ),
    "vehicle_name": MessageLookupByLibrary.simpleMessage("Nome do veículo"),
    "vehicle_papers": MessageLookupByLibrary.simpleMessage(
      "Documentos do veículo",
    ),
    "vehicle_papers_required": MessageLookupByLibrary.simpleMessage(
      "Documentos do veículo são obrigatórios",
    ),
    "vehicle_plate_number": MessageLookupByLibrary.simpleMessage(
      "Número da placa do veículo",
    ),
    "vehicle_production_year": MessageLookupByLibrary.simpleMessage(
      "Ano de fabricação do veículo",
    ),
    "vehicle_type": MessageLookupByLibrary.simpleMessage("Tipo de veículo"),
    "verify": MessageLookupByLibrary.simpleMessage("Verificar"),
    "view_all": MessageLookupByLibrary.simpleMessage("Ver Tudo"),
    "wallet": MessageLookupByLibrary.simpleMessage("Carteira"),
    "wallet_balance": MessageLookupByLibrary.simpleMessage("Saldo da Carteira"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Bem-vindo de volta!"),
    "withdraw": MessageLookupByLibrary.simpleMessage("Sacar"),
    "withdraw_history": MessageLookupByLibrary.simpleMessage(
      "Histórico de Saques",
    ),
    "withdraw_instruction": MessageLookupByLibrary.simpleMessage(
      "Você ganhou! Escolha para onde enviar seu dinheiro e clique em sacar.",
    ),
    "withdraw_your_earnings": MessageLookupByLibrary.simpleMessage(
      "Saque Seus Ganhos",
    ),
    "withdrawal_request_success": m7,
    "withdrawal_success": MessageLookupByLibrary.simpleMessage(
      "Solicitação de Saque Enviada com Sucesso!",
    ),
    "write": m8,
    "writeIssueDetails": MessageLookupByLibrary.simpleMessage(
      "Descreva os Detalhes do Problema",
    ),
    "yourAccountAlreadyActive": MessageLookupByLibrary.simpleMessage(
      "Sua conta já está ativa em outro dispositivo. Para usar aqui, o outro dispositivo será desconectado.",
    ),
    "your_balance": MessageLookupByLibrary.simpleMessage("Seu Saldo"),
    "your_best_photo_here": MessageLookupByLibrary.simpleMessage(
      "Sua melhor foto aqui",
    ),
    "your_ride_complete": MessageLookupByLibrary.simpleMessage(
      "Viagem Concluída",
    ),
  };
}
