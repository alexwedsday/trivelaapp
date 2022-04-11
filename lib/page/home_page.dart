import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivelaapp/component/dashboard.dart';
import 'package:trivelaapp/component/shop_list.dart';
import 'package:trivelaapp/controller/home_page_controller.dart';
import 'package:trivelaapp/page/deposit_page.dart';
import 'package:trivelaapp/page/login_page.dart';
import 'package:trivelaapp/page/settings_page.dart';
import 'package:trivelaapp/response/saldo_response.dart';
import 'package:trivelaapp/shared/trivela_assets.dart';

class HomePage extends StatefulWidget {
  final int index;

  const HomePage({Key key, this.index}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _expandedMenuFinancial = false;
  bool _expandedSubFinancial = false;
  bool _expandedMenuCartola = false;
  bool _expandedMenuTransaction = false;
  bool _expandedMenuParticipation = false;
  HomePageController _controller;
  String _balance;
  String _balanceBonus;
  String _balanceReal;

  int selected;

  @override
  void initState() {
    super.initState();
    _controller = HomePageController();
    setState(() {
      _balance = '0,00';
      _balanceReal = '0,00';
      _balanceBonus = '0,00';
      selected = widget.index;
    });
    _saldo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MaterialApp(
          title: 'Inicio',
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black54),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    _selectComponent(1, context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage(
                              index: 1,
                            )));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.notifications_none),
                  onPressed: () {},
                ),
                PopupMenuButton(
                  icon: Icon(Icons.account_circle, color: Colors.orangeAccent),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Configurações'),
                        onTap: () => {_goToSettings(context)},
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: ListTile(
                        leading: Icon(Icons.attach_money),
                        title: Text('Bancos'),
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: ListTile(
                        leading: Icon(Icons.credit_card),
                        title: Text('Financeiro'),
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 3,
                      child: ListTile(
                        leading: Icon(Icons.group),
                        title: Text('Times'),
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 3,
                      child: ListTile(
                        leading: Icon(Icons.exit_to_app),
                        title: Text('Sair'),
                        onTap: () => {_leave(context)},
                      ),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {
                      _saldo();
                    },
                    child: Center(child: Text('Saldo \n R\$ ${_balance}'))),
              ],
            ),
            drawer: Drawer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    child: DrawerHeader(
                      child: Image(
                        width: 50,
                        image: AssetImage(TrivelaAssets.logoPng),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          title: Text('E-COMMERCE'),
                        ),
                        ListTile(
                          leading: Icon(Icons.shopping_cart),
                          title: Text('Shop'),
                          onTap: () {
                            _selectComponent(1, context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage(
                                      index: 1,
                                    )));
                          },
                        ),
                        ListTile(
                          title: Text('MINHA CONTA'),
                        ),
                        ExpansionTile(
                          leading: Icon(Icons.attach_money),
                          title: Text('Financeiro'),
                          trailing: Icon(
                            _expandedMenuFinancial
                                ? Icons.arrow_drop_down
                                : Icons.arrow_forward_ios,
                            size: 10,
                          ),
                          onExpansionChanged: (bool expanded) {
                            setState(() => _expandedMenuFinancial = expanded);
                          },
                          children: <Widget>[
                            ExpansionTile(
                              leading: Icon(Icons.panorama_fish_eye),
                              title: Text('Transações'),
                              trailing: Icon(
                                  _expandedSubFinancial
                                      ? Icons.arrow_drop_down
                                      : Icons.arrow_forward_ios,
                                  size: 10),
                              onExpansionChanged: (bool expanded) {
                                setState(
                                    () => _expandedSubFinancial = expanded);
                              },
                              children: <Widget>[
                                ListTile(
                                  title: Center(child: Text('Comprar')),
                                  onTap: () {
                                    _selectComponent(1, context);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => HomePage(
                                                  index: 2,
                                                )));
                                  },
                                ),
                                ListTile(
                                  title: Center(
                                    child: Text('Saque'),
                                  ),
                                ),
                                ListTile(
                                  title: Center(
                                    child: Text('Visualizar'),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        ListTile(
                          leading: Icon(Icons.account_balance),
                          title: Text('Bancos'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Configurações'),
                          onTap: () {
                            _goToSettings(context);
                          },
                        ),
                        // ListTile(
                        //   title: Text('PARCIAIS'),
                        // ),
                        ListTile(
                          leading: Icon(Icons.view_list),
                          title: Text('Meus Campeonatos'),
                          onTap: () {},
                        ),
                        // ListTile(
                        //   leading: Icon(Icons.group),
                        //   title: Text('Grupos'),
                        //   onTap: () {},
                        // ),
                        ExpansionTile(
                          leading: Icon(Icons.casino),
                          title: Text('Cartola'),
                          trailing: Icon(
                            _expandedMenuCartola
                                ? Icons.arrow_drop_down
                                : Icons.arrow_forward_ios,
                            size: 10,
                          ),
                          onExpansionChanged: (bool expanded) {
                            setState(() => _expandedMenuCartola = expanded);
                          },
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.panorama_fish_eye),
                              title: Text('Times'),
                            ),
                            // ListTile(
                            //   leading: Icon(Icons.panorama_fish_eye),
                            //   title: Text('Jogadores'),
                            // ),
                            // ListTile(
                            //   leading: Icon(Icons.panorama_fish_eye),
                            //   title: Text('Jogos'),
                            // )
                          ],
                        ),
                        ListTile(
                          title: Text('RELATÓRIOS'),
                        ),
                        ExpansionTile(
                          leading: Icon(Icons.print),
                          title: Text('Transações'),
                          trailing: Icon(
                            _expandedMenuTransaction
                                ? Icons.arrow_drop_down
                                : Icons.arrow_forward_ios,
                            size: 10,
                          ),
                          onExpansionChanged: (bool expanded) {
                            setState(() => _expandedMenuTransaction = expanded);
                          },
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.panorama_fish_eye),
                              title: Text('Deposito/Saque'),
                            )
                          ],
                        ),
                        // ExpansionTile(
                        //   leading: Icon(Icons.print),
                        //   title: Text('Participações'),
                        //   trailing: Icon(
                        //     _expandedMenuParticipation
                        //         ? Icons.arrow_drop_down
                        //         : Icons.arrow_forward_ios,
                        //     size: 10,
                        //   ),
                        //   onExpansionChanged: (bool expanded) {
                        //     setState(() => _expandedMenuParticipation = expanded);
                        //   },
                        //   children: <Widget>[
                        //     ListTile(
                        //       leading: Icon(Icons.panorama_fish_eye),
                        //       title: Text('Resultados'),
                        //     ),
                        //     ListTile(
                        //         leading: Icon(Icons.panorama_fish_eye),
                        //         title: Text('Histórico de Ganhos'))
                        //   ],
                        // ),
                        ListTile(
                          leading: Icon(Icons.exit_to_app),
                          title: Text('Sair'),
                          onTap: () {
                            _leave(context);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: _selectComponent(selected, context),
          ),
        ),
        onWillPop: _onWillPop);
  }

  _goToSettings(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsPage()));
  }

  _leave(BuildContext context) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _saldo() async {
    SaldoResponse saldoReal = await _controller.getSaldo();
    SaldoResponse saldoBonus = await _controller.getSaldoBonus();

    if (saldoReal != null && !saldoReal.error) {
      final double saldo = _somaSaldo(saldoReal?.saldo, saldoBonus?.saldo);
      setState(() {
        _balanceBonus = formatSaldo(saldoBonus?.saldo);
        _balanceReal = formatSaldo(saldoReal?.saldo);
        _balance = formatSaldo(saldo);
      });
    }
  }

  String formatSaldo(double value) {
    String str;
    try {
      final formatter = new NumberFormat("###,##0.00", "pt-Br");
      str = formatter.format(value);
    } catch (e) {}

    return str;
  }

  double _somaSaldo(double real, double bonus) {
    double retorno = 0.0;

    if (real != null && bonus != null) retorno = real + bonus;

    return retorno;
  }

  StatefulWidget _selectComponent(int index, BuildContext context) {
    setState(() {
      selected = index;
    });
    switch (index) {
      case 0:
        return Dashboard();
        break;

      case 1:
        return new ShopList();
        break;

      case 2:
        return new DepositPage();
        break;

      default:
        return Dashboard();
        break;
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Atenção!'),
            content: new Text('Deseja finalizar o Trivela ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Não'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Sim'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
