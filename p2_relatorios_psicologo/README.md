Aplicativo desenvolvido em **Flutter** para a disciplina de **Desenvolvimento para Dispositivos Móveis**, com o objetivo de consolidar os conteúdos vistos em aula: navegação, formulários, consumo de API externa e armazenamento local.

O app simula o dia a dia de um(a) psicólogo(a), permitindo **cadastro de pacientes** e **registro de relatórios de sessão**, com dados persistidos localmente.

---

## Funcionalidades

### 1. Gestão de Pacientes

* Listagem de pacientes cadastrados.
* Botão flutuante (**+**) para **adicionar novo paciente**.
* Formulário contendo:

  * Nome
  * Idade
  * CEP
  * Observações
* Integração com a API pública **ViaCEP**:

  * Endpoint: `https://viacep.com.br/ws/{CEP}/json/`
  * Botão **“Buscar CEP”** que preenche automaticamente o endereço do paciente a partir do CEP informado.
* Tela de **detalhes do paciente**, exibindo todas as informações cadastradas.

### 2. Relatórios de Sessão

* Aba específica para **Relatórios**.
* Seleção de paciente através de um `DropdownButton`.
* Formulário de criação de relatório com:

  * **Data da sessão** (DatePicker)
  * **Tipo da sessão** (Switch alternando entre *Presencial* e *Online*)
  * **Humor do paciente** (Slider de 1 a 10)
  * **Observações** (TextField multiline)
* Salvamento do relatório e exibição de feedback ao usuário via **SnackBar**.
* Listagem dos relatórios, filtrados pelo paciente selecionado.
* Tela de **detalhes do relatório**, exibindo:

  * Paciente
  * Data
  * Tipo da sessão
  * Humor
  * Observações

---

## Tecnologias e Conceitos Utilizados

* **Flutter** (Dart)
* **Widgets obrigatórios exigidos na disciplina**:

  * `TextField`
  * `ListView`
  * `Text`
  * `DropdownButton`
  * `Switch`
  * `Slider`
  * `SnackBar`
* **Navegação**

  * `BottomNavigationBar` para alternar entre as abas **Pacientes** e **Relatórios**
  * `Navigator.push` / `Navigator.pop` para formulários e telas de detalhes
* **Consumo de API externa**

  * Pacote `http` para requisição à API **ViaCEP**
* **Armazenamento local**

  * **Hive** / `hive_flutter` para persistência:

    * Box de pacientes
    * Box de relatórios
  * Dados permanecem disponíveis entre execuções do app

---

## Estrutura Geral do App

* `lib/main.dart`
  Inicializa o Hive, registra os adapters e abre as boxes, além de iniciar o `HomePage`.

* `lib/pages/home_page.dart`
  Tela principal com `BottomNavigationBar` e controle das abas **Pacientes** e **Relatórios**.

* `lib/models/patient.dart`
  Modelo `Patient` com campos de identificação, dados pessoais e endereço.

* `lib/models/report.dart`
  Modelo `Report` com informações da sessão (data, tipo, humor e observações).

* `lib/pages/patients/`

  * `patients_page.dart` – Lista de pacientes e botão para cadastro.
  * `patient_form_page.dart` – Formulário de novo paciente + integração ViaCEP.
  * `patient_detail_page.dart` – Detalhes do paciente selecionado.

* `lib/pages/reports/`

  * `reports_page.dart` – Seleção de paciente, formulário de relatório e listagem.
  * `report_detail_page.dart` – Detalhes do relatório selecionado.

* `lib/services/cep_service.dart`
  Função para buscar o endereço na API ViaCEP a partir do CEP.

* `lib/data/hive_boxes.dart`
  Acesso centralizado às boxes do Hive (pacientes e relatórios).

---

## Execução do Projeto

1. Certifique-se de ter o **Flutter** instalado e configurado.
2. Clone ou extraia o projeto.
3. Na raiz do projeto, execute:

```bash
flutter pub get
flutter run
```

4. Selecione o dispositivo (emulador, dispositivo físico ou navegador) e aguarde o app iniciar.


