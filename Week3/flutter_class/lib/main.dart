import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:typed_data';

void main() {
  runApp(const MyInheritedData(
    data: 'Inherited Value dari Slide 14',
    child: LyricsApp(),
  ));
}


// Slide 14: InheritedWidget

class MyInheritedData extends InheritedWidget {
  final String data;

  const MyInheritedData({
    super.key,
    required this.data,
    required super.child,
  });

  static MyInheritedData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInheritedData>();

  @override
  bool updateShouldNotify(MyInheritedData old) => data != old.data;
}


// Root App

class LyricsApp extends StatelessWidget {
  const LyricsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Slide 5: MaterialApp — root widget Material Design
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Widget Flutter',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      // Slide 11: Navigator (dikelola otomatis oleh MaterialApp)
      home: const MainPage(),
      routes: {
        '/cupertino': (context) => const CupertinoPage(),
      },
    );
  }
}
// Main Page — dengan BottomNavigationBar & TabBar

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    const LayoutAndStructuralPage(), // Slide 4 & 5
    const TextIconButtonPage(), // Slide 6 & 7
    const InputFormPage(), // Slide 8
    const MediaListPage(), // Slide 9 & 10
    const NavDialogAnimationPage(), // Slide 11, 12, 13, 14
  ];

  @override
  Widget build(BuildContext context) {
    // Slide 5: Scaffold — kerangka dasar halaman
    return Scaffold(
      // Slide 5: AppBar
      appBar: AppBar(
        title: const Text('Katalog Widget Flutter'),
        centerTitle: true,
        actions: [
          // Slide 7: PopupMenuButton
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'cupertino') {
                // Slide 11: Navigator.push
                Navigator.push(
                  context,
                  // Slide 11: PageRouteBuilder — transisi custom
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const CupertinoPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 'cupertino', child: Text('iOS Widgets')),
            ],
          ),
        ],
      ),
      // Slide 5: Drawer — panel navigasi geser
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text('Menu Navigasi',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Layout'),
              onTap: () {
                setState(() => _currentIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_fields),
              title: const Text('Teks & Tombol'),
              onTap: () {
                setState(() => _currentIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.input),
              title: const Text('Input & Form'),
              onTap: () {
                setState(() => _currentIndex = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Media & List'),
              onTap: () {
                setState(() => _currentIndex = 3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.animation),
              title: const Text('Navigasi & Animasi'),
              onTap: () {
                setState(() => _currentIndex = 4);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      // Slide 11: BottomNavigationBar — navigasi bawah
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.widgets), label: 'Layout'),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_fields), label: 'Teks'),
          BottomNavigationBarItem(icon: Icon(Icons.input), label: 'Input'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Media'),
          BottomNavigationBarItem(
              icon: Icon(Icons.animation), label: 'Animasi'),
        ],
      ),
      // FloatingActionButton — tombol aksi utama (Slide 7)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            // Slide 12: SnackBar
            const SnackBar(
              content: Text('FloatingActionButton ditekan! (Slide 7 & 12)'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


// Page 1: Slide 4 (Layout) & Slide 5 (Struktural)

class LayoutAndStructuralPage extends StatelessWidget {
  const LayoutAndStructuralPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Slide 5: SafeArea — menghindari area sistem
    return SafeArea(
      // Slide 7: SingleChildScrollView dipindah ke MediaListPage,
      // di sini pakai SingleChildScrollView untuk konten panjang
      child: SingleChildScrollView(
        // Slide 4: Padding — memberi jarak dalam
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Slide 4: Layout Widgets'),

            // Slide 4: Container — menggabungkan ukuran, padding, decoration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.deepPurple),
              ),
              child: const Text('Container — padding, margin, decoration'),
            ),

            // Slide 4: Row — horizontal
            Row(
              children: [
                // Slide 4: Expanded — isi sisa ruang
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.blue.shade100,
                    child: const Center(child: Text('Expanded 1')),
                  ),
                ),
                const SizedBox(width: 8),
                // Slide 4: Flexible — proporsi fleksibel
                Flexible(
                  flex: 2,
                  child: Container(
                    height: 50,
                    color: Colors.green.shade100,
                    child: const Center(child: Text('Flexible flex:2')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Slide 4: Stack — menumpuk widget
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.orange.shade100,
                ),
                const Text('Stack — Layer Bawah',
                    style: TextStyle(fontSize: 16)),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    color: Colors.orange,
                    child: const Text('Positioned',
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Slide 4: SizedBox — ukuran tetap
            const SizedBox(
              width: double.infinity,
              height: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.purple),
                child: Center(
                  child: Text('SizedBox 40px tinggi',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Slide 4: Padding eksplisit
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Container(
                color: Colors.teal.shade100,
                child: const Center(child: Text('Padding horizontal:24')),
              ),
            ),

            const SizedBox(height: 16),
            _sectionTitle('Slide 5: Struktural & App Widgets'),

            // Slide 5: Center — menempatkan child di tengah
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.pink.shade50,
                child: const Text('Center Widget'),
              ),
            ),
            const SizedBox(height: 12),

            // Slide 5: Align — posisi tertentu
            Container(
              height: 60,
              color: Colors.yellow.shade100,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text('Align → kanan'),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Slide 5: BottomSheet (tombol trigger)
            ElevatedButton(
              onPressed: () {
                // Slide 12: showModalBottomSheet
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => Container(
                    padding: const EdgeInsets.all(20),
                    height: 200,
                    child: Column(
                      children: [
                        const Text('BottomSheet (Slide 5 & 12)',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        const Text(
                            'Panel yang muncul dari bawah layar.\nshowModalBottomSheet dari Slide 12.'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Tutup')),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Tampilkan BottomSheet (Slide 5 & 12)'),
            ),
          ],
        ),
      ),
    );
  }
}


// Page 2: Slide 6 (Teks & Ikon) & Slide 7 (Tombol)

class TextIconButtonPage extends StatefulWidget {
  const TextIconButtonPage({super.key});

  @override
  State<TextIconButtonPage> createState() => _TextIconButtonPageState();
}

class _TextIconButtonPageState extends State<TextIconButtonPage> {
  String _dropdownValue = 'Option A';
  final List<String> _dropdownItems = ['Option A', 'Option B', 'Option C'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Slide 6: Teks & Ikon Widgets'),

          // Slide 6: Text dengan TextStyle
          const Text(
            'Text + TextStyle',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          const SizedBox(height: 8),

          // Slide 6: RichText — teks dengan beberapa gaya
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 16, color: Colors.black),
              children: [
                TextSpan(text: 'RichText: '),
                TextSpan(
                    text: 'Tebal ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'Miring ',
                    style: TextStyle(fontStyle: FontStyle.italic)),
                TextSpan(
                    text: 'Warna',
                    style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.underline)),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Slide 6: SelectableText — teks yang dapat dipilih
          const SelectableText(
            'SelectableText — coba klik dan drag untuk memilih teks ini.',
            style: TextStyle(fontSize: 14, color: Colors.teal),
          ),
          const SizedBox(height: 8),

          // Slide 6: Icon
          const Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 32),
              SizedBox(width: 8),
              Icon(Icons.favorite, color: Colors.red, size: 32),
              SizedBox(width: 8),
              Icon(Icons.music_note, color: Colors.deepPurple, size: 32),
              SizedBox(width: 8),
              // Slide 6: ImageIcon — ikon dari gambar
              ImageIcon(
                AssetImage('assets/MIMU.webp'),
                size: 32,
                color: Colors.brown,
              ),
            ],
          ),
          const SizedBox(height: 16),

          _sectionTitle('Slide 7: Tombol (Button) Widgets'),

          // Slide 7: ElevatedButton
          ElevatedButton(
            onPressed: () {},
            child: const Text('ElevatedButton'),
          ),
          const SizedBox(height: 8),

          // Slide 7: TextButton
          TextButton(
            onPressed: () {},
            child: const Text('TextButton'),
          ),
          const SizedBox(height: 8),

          // Slide 7: OutlinedButton
          OutlinedButton(
            onPressed: () {},
            child: const Text('OutlinedButton'),
          ),
          const SizedBox(height: 8),

          // Slide 7: IconButton
          Row(
            children: [
              const Text('IconButton: '),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_previous, color: Colors.blue)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow, color: Colors.green)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_next, color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 8),

          // Slide 7: DropdownButton
          Row(
            children: [
              const Text('DropdownButton: '),
              DropdownButton<String>(
                value: _dropdownValue,
                items: _dropdownItems
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _dropdownValue = val);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Slide 7: ButtonBar (diganti OverflowBar — pengganti resmi ButtonBar)
          OverflowBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('OK')),
              TextButton(onPressed: () {}, child: const Text('Batal')),
              OutlinedButton(onPressed: () {}, child: const Text('Lainnya')),
            ],
          ),

          // Slide 7: Tooltip — keterangan saat widget ditekan lama
          const Center(
            child: Tooltip(
              message: 'Ini adalah Tooltip dari Slide 12',
              child: Chip(label: Text('Hover/Long-press untuk Tooltip')),
            ),
          ),
        ],
      ),
    );
  }
}


// Page 3: Slide 8 (Input & Form)

class InputFormPage extends StatefulWidget {
  const InputFormPage({super.key});

  @override
  State<InputFormPage> createState() => _InputFormPageState();
}

class _InputFormPageState extends State<InputFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _checkboxValue = false;
  String? _radioValue = 'A';
  bool _switchValue = false;
  double _sliderValue = 0.5;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Slide 8: Input & Form Widgets'),

          // Slide 8: Form — wadah validasi
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Slide 8: TextField
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'TextField — input teks bebas',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 12),

                // Slide 8: TextFormField — validasi
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'TextFormField — dengan validasi',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Field tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Form valid!')),
                      );
                    }
                  },
                  child: const Text('Validasi Form'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Slide 8: Checkbox
          CheckboxListTile(
            title: const Text('Checkbox — centang pilihan'),
            value: _checkboxValue,
            onChanged: (val) => setState(() => _checkboxValue = val ?? false),
          ),

          // Slide 8: Radio — pilihan tunggal (menggunakan RadioGroup)
          const Text('Radio — pilihan tunggal:'),
          RadioGroup<String>(
            groupValue: _radioValue,
            onChanged: (v) => setState(() => _radioValue = v),
            child: Row(
              children: ['A', 'B', 'C'].map((val) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(value: val),
                    Text(val),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),

          // Slide 8: Switch
          SwitchListTile(
            title: Text('Switch — on/off: ${_switchValue ? "ON" : "OFF"}'),
            value: _switchValue,
            onChanged: (val) => setState(() => _switchValue = val),
          ),

          // Slide 8: Slider
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Slider: ${(_sliderValue * 100).toStringAsFixed(0)}%'),
              Slider(
                value: _sliderValue,
                onChanged: (val) => setState(() => _sliderValue = val),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Slide 8: DatePicker
          Row(
            children: [
              Text(
                  'Tanggal: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => _selectedDate = picked);
                  }
                },
                child: const Text('DatePicker'),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Slide 8: TimePicker
          Row(
            children: [
              Text('Waktu: ${_selectedTime.format(context)}'),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime,
                  );
                  if (picked != null) {
                    setState(() => _selectedTime = picked);
                  }
                },
                child: const Text('TimePicker'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// Page 4: Slide 9 (Gambar & Media) & Slide 10 (List & Scrolling)

class MediaListPage extends StatefulWidget {
  const MediaListPage({super.key});

  @override
  State<MediaListPage> createState() => _MediaListPageState();
}

class _MediaListPageState extends State<MediaListPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<String> _reorderable = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slide 11: TabBar
        TabBar(
          controller: _tabController,
          labelColor: Colors.deepPurple,
          tabs: const [
            Tab(icon: Icon(Icons.image), text: 'Slide 9: Media'),
            Tab(icon: Icon(Icons.list), text: 'Slide 10: List'),
          ],
        ),

        // Slide 11: TabBarView
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // ─── Tab 1: Gambar & Media (Slide 9) ───
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Slide 9: Gambar & Media Widgets'),

                    // Slide 9: Image.asset
                    Center(
                      child: Image.asset(
                        'assets/MIMU.webp',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Slide 9: CircleAvatar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.deepPurple,
                          child: Text('JD',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20)),
                        ),
                        const SizedBox(width: 12),
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              const AssetImage('assets/MIMU.webp'),
                          child: Container(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Slide 9: Card
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: const ListTile(
                        leading: Icon(Icons.album, color: Colors.deepPurple),
                        title: Text('Card Widget'),
                        subtitle: Text('Elevasi & sudut membulat — Slide 9'),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Slide 9: ClipRRect — memotong sudut membulat
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/MIMU.webp',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Slide 9: Hero — animasi transisi antar halaman
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HeroDetailPage(),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'hero-image',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/MIMU.webp',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text('Tap gambar di atas → Hero animation',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                    const SizedBox(height: 12),

                    // Slide 9: FadeInImage — gambar dengan efek fade
                    Center(
                      child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: const AssetImage('assets/MIMU.webp'),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Center(
                      child: Text('FadeInImage (Slide 9)',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                  ],
                ),
              ),

              // ─── Tab 2: List & Scrolling (Slide 10) ───
              SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Slide 10: List & Scrolling Widgets'),

                    // Slide 10: ListView
                    const Text('ListView:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 120,
                      // Slide 10: Scrollbar — indikator scroll
                      child: Scrollbar(
                        child: ListView(
                          children: List.generate(
                            6,
                            (i) => ListTile(
                              leading: const Icon(Icons.music_note),
                              title: Text('Lagu ${i + 1}'),
                              dense: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Slide 10: GridView
                    const Text('GridView:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        6,
                        (i) => Card(
                          child: Center(
                            child: Text('Grid ${i + 1}'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Slide 10: Wrap — pindah baris otomatis
                    const Text('Wrap:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: ['Flutter', 'Dart', 'Widget', 'Layout', 'State']
                          .map((tag) => Chip(label: Text(tag)))
                          .toList(),
                    ),
                    const SizedBox(height: 12),

                    // Slide 10: PageView
                    const Text('PageView:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 80,
                      child: PageView(
                        children: [
                          Container(
                              color: Colors.blue.shade100,
                              child:
                                  const Center(child: Text('Page 1 (PageView)'))),
                          Container(
                              color: Colors.green.shade100,
                              child:
                                  const Center(child: Text('Page 2 (PageView)'))),
                          Container(
                              color: Colors.orange.shade100,
                              child:
                                  const Center(child: Text('Page 3 (PageView)'))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Slide 10: CustomScrollView — dengan SliverList & SliverAppBar
                    const Text('CustomScrollView + Sliver:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 150,
                      child: CustomScrollView(
                        slivers: [
                          const SliverAppBar(
                            title: Text('SliverAppBar'),
                            floating: true,
                            expandedHeight: 40,
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate([
                              const ListTile(title: Text('Sliver Item 1')),
                              const ListTile(title: Text('Sliver Item 2')),
                              const ListTile(title: Text('Sliver Item 3')),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Slide 10: ReorderableListView
                    const Text('ReorderableListView:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 160,
                      child: ReorderableListView(
                        onReorderItem: (int oldIndex, int newIndex) {
                          setState(() {
                            final item = _reorderable.removeAt(oldIndex);
                            _reorderable.insert(newIndex, item);
                          });
                        },
                        children: _reorderable
                            .map(
                              (item) => ListTile(
                                key: ValueKey(item),
                                title: Text(item),
                                trailing: const Icon(Icons.drag_handle),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// Page 5: Slide 11 (Navigasi), 12 (Dialog), 13 (Animasi), 14 (Async)

class NavDialogAnimationPage extends StatefulWidget {
  const NavDialogAnimationPage({super.key});

  @override
  State<NavDialogAnimationPage> createState() => _NavDialogAnimationPageState();
}

class _NavDialogAnimationPageState extends State<NavDialogAnimationPage>
    with TickerProviderStateMixin {
  // Slide 13: AnimatedContainer
  bool _expanded = false;
  // Slide 13: AnimatedOpacity
  bool _visible = true;
  // Slide 13: AnimatedSwitcher
  bool _showFirst = true;
  // Slide 11: NavigationRail
  int _railIndex = 0;

  // Slide 13: FadeTransition + ScaleTransition controller
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

  // Slide 14: ValueListenableBuilder
  final ValueNotifier<int> _counter = ValueNotifier(0);

  // Slide 14: FutureBuilder
  Future<String> _fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Data dari Future berhasil dimuat!';
  }

  // Slide 14: StreamBuilder
  Stream<int> _countStream() async* {
    for (int i = 0; i <= 5; i++) {
      await Future.delayed(const Duration(milliseconds: 600));
      yield i;
    }
  }

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _fadeAnim =
        Tween<double>(begin: 0.2, end: 1.0).animate(_animController);
    _scaleAnim =
        Tween<double>(begin: 0.8, end: 1.2).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Slide 14: InheritedWidget — baca data
    final inheritedData = MyInheritedData.of(context)?.data ?? '-';

    return Row(
      children: [
        // Slide 11: NavigationRail
        NavigationRail(
          selectedIndex: _railIndex,
          onDestinationSelected: (i) => setState(() => _railIndex = i),
          labelType: NavigationRailLabelType.selected,
          destinations: const [
            NavigationRailDestination(
                icon: Icon(Icons.chat), label: Text('Dialog')),
            NavigationRailDestination(
                icon: Icon(Icons.animation), label: Text('Animasi')),
            NavigationRailDestination(
                icon: Icon(Icons.sync), label: Text('Async')),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: IndexedStack(
            index: _railIndex,
            children: [
              // ─── Rail 0: Dialog & Feedback (Slide 12) ───
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Slide 12: Dialog & Feedback'),

                    // Slide 12: AlertDialog
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('AlertDialog'),
                            content: const Text(
                                'Ini adalah dialog konfirmasi.\n(Slide 12 — AlertDialog & showDialog)'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text('Tutup')),
                              ElevatedButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text('OK')),
                            ],
                          ),
                        );
                      },
                      child: const Text('Tampilkan AlertDialog'),
                    ),
                    const SizedBox(height: 8),

                    // Slide 12: SnackBar
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Ini SnackBar dari Slide 12!'),
                            backgroundColor: Colors.deepPurple,
                          ),
                        );
                      },
                      child: const Text('Tampilkan SnackBar'),
                    ),
                    const SizedBox(height: 8),

                    // Slide 12: Tooltip
                    const Tooltip(
                      message: 'Ini adalah Tooltip — tekan lama!',
                      child: ElevatedButton(
                        onPressed: null,
                        child: Text('Hover/Long-press → Tooltip'),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Slide 12: CircularProgressIndicator
                    const Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Text('CircularProgressIndicator'),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Slide 12: LinearProgressIndicator
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LinearProgressIndicator:'),
                        SizedBox(height: 4),
                        LinearProgressIndicator(),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Slide 12: showModalBottomSheet
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (ctx) => Container(
                            padding: const EdgeInsets.all(16),
                            height: 180,
                            child: Column(
                              children: [
                                const Text('showModalBottomSheet',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                const Text('Panel modal dari bawah (Slide 12)'),
                                const Spacer(),
                                ElevatedButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text('Tutup')),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Text('showModalBottomSheet'),
                    ),
                    const SizedBox(height: 8),

                    // Slide 12: Banner
                    Banner(
                      message: 'NEW',
                      location: BannerLocation.topEnd,
                      color: Colors.deepPurple,
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        color: Colors.deepPurple.shade50,
                        child: const Center(
                          child: Text('Banner Widget — Slide 12'),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    _sectionTitle('Slide 11: Navigasi Lanjutan'),

                    // Slide 11: Navigator.push ke halaman baru
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HeroDetailPage(),
                          ),
                        );
                      },
                      child: const Text('Navigator.push → Halaman Baru'),
                    ),
                    const SizedBox(height: 8),

                    // Slide 11: PageRouteBuilder — transisi custom
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const HeroDetailPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text('PageRouteBuilder — Slide Transition'),
                    ),
                  ],
                ),
              ),

              // ─── Rail 1: Animasi (Slide 13) ───
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Slide 13: Animation Widgets'),

                    // Slide 13: AnimatedContainer
                    const Text('AnimatedContainer:'),
                    GestureDetector(
                      onTap: () => setState(() => _expanded = !_expanded),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        width: _expanded ? double.infinity : 150,
                        height: _expanded ? 80 : 40,
                        color: _expanded
                            ? Colors.deepPurple
                            : Colors.deepPurple.shade100,
                        alignment: Alignment.center,
                        child: Text(
                          _expanded ? 'Tap untuk kecil' : 'Tap untuk besar',
                          style: TextStyle(
                              color: _expanded ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Slide 13: AnimatedOpacity
                    const Text('AnimatedOpacity:'),
                    GestureDetector(
                      onTap: () => setState(() => _visible = !_visible),
                      child: AnimatedOpacity(
                        opacity: _visible ? 1.0 : 0.1,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.teal,
                          child: const Center(
                              child: Text('Tap → AnimatedOpacity',
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Slide 13: AnimatedSwitcher
                    const Text('AnimatedSwitcher:'),
                    GestureDetector(
                      onTap: () => setState(() => _showFirst = !_showFirst),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: Container(
                          key: ValueKey(_showFirst),
                          height: 60,
                          width: double.infinity,
                          color: _showFirst
                              ? Colors.amber.shade200
                              : Colors.blue.shade200,
                          child: Center(
                            child: Text(
                              _showFirst ? 'Widget A' : 'Widget B',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Slide 13: FadeTransition
                    const Text('FadeTransition:'),
                    FadeTransition(
                      opacity: _fadeAnim,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.green.shade300,
                        child: const Center(
                            child: Text('FadeTransition (auto-animasi)')),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Slide 13: ScaleTransition
                    const Text('ScaleTransition:'),
                    Center(
                      child: ScaleTransition(
                        scale: _scaleAnim,
                        child: Container(
                          height: 60,
                          width: 60,
                          color: Colors.red.shade300,
                          child: const Center(
                              child: Text('Scale',
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ─── Rail 2: Async & State (Slide 14) ───
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Slide 14: Async & State Widgets'),

                    // Slide 14: InheritedWidget
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('InheritedWidget:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Data: $inheritedData',
                                style: const TextStyle(color: Colors.teal)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Slide 14: FutureBuilder
                    const Text('FutureBuilder:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    FutureBuilder<String>(
                      future: _fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Row(children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 8),
                            Text('Loading Future...')
                          ]);
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        return Text(' ${snapshot.data}',
                            style: const TextStyle(color: Colors.green));
                      },
                    ),
                    const SizedBox(height: 12),

                    // Slide 14: StreamBuilder
                    const Text('StreamBuilder:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    StreamBuilder<int>(
                      stream: _countStream(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Text('Menunggu stream...');
                        }
                        return Text(
                          'Stream nilai: ${snapshot.data} / 5',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.deepPurple),
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    // Slide 14: ValueListenableBuilder
                    const Text('ValueListenableBuilder:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    ValueListenableBuilder<int>(
                      valueListenable: _counter,
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            Text('Counter: $value',
                                style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: () => _counter.value++,
                              child: const Text('+1'),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),

                    // Slide 14: StatelessWidget & StatefulWidget info
                    Card(
                      color: Colors.blue.shade50,
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('StatelessWidget & StatefulWidget:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(
                                '• LyricsApp = StatelessWidget\n• MainPage, InputFormPage, dll = StatefulWidget'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// Slide 9 & 11: Hero Detail Page

class HeroDetailPage extends StatelessWidget {
  const HeroDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Detail (Slide 9 & 11)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Slide 9: Hero widget pada halaman tujuan
            Hero(
              tag: 'hero-image',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset('assets/MIMU.webp',
                    width: 250, height: 250, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),
            const Text('I Miss You — Hero Transition',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}


// Slide 15: Cupertino (iOS-style) Page

class CupertinoPage extends StatefulWidget {
  const CupertinoPage({super.key});

  @override
  State<CupertinoPage> createState() => _CupertinoPageState();
}

class _CupertinoPageState extends State<CupertinoPage> {
  bool _cupertinoSwitch = false;
  int _pickerIndex = 0;
  final List<String> _pickerItems = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  final TextEditingController _cupertinoTextCtrl = TextEditingController();

  @override
  void dispose() {
    _cupertinoTextCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Slide 15: CupertinoNavigationBar
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Slide 15: Cupertino Widgets'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Slide 15: Cupertino (iOS-style) Widgets',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Slide 15: CupertinoButton
              CupertinoButton(
                color: CupertinoColors.activeBlue,
                onPressed: () {
                  // Slide 15: CupertinoAlertDialog
                  showCupertinoDialog(
                    context: context,
                    builder: (ctx) => CupertinoAlertDialog(
                      title: const Text('CupertinoAlertDialog'),
                      content: const Text('Dialog peringatan bergaya iOS (Slide 15)'),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Batal'),
                        ),
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('CupertinoButton → CupertinoAlertDialog'),
              ),
              const SizedBox(height: 16),

              // Slide 15: CupertinoSwitch
              Row(
                children: [
                  const Text('CupertinoSwitch: '),
                  CupertinoSwitch(
                    value: _cupertinoSwitch,
                    onChanged: (val) => setState(() => _cupertinoSwitch = val),
                  ),
                  const SizedBox(width: 8),
                  Text(_cupertinoSwitch ? 'ON' : 'OFF'),
                ],
              ),
              const SizedBox(height: 16),

              // Slide 15: CupertinoTextField
              const Text('CupertinoTextField:'),
              const SizedBox(height: 4),
              CupertinoTextField(
                controller: _cupertinoTextCtrl,
                placeholder: 'Input teks bergaya iOS...',
                padding: const EdgeInsets.all(10),
              ),
              const SizedBox(height: 16),

              // Slide 15: CupertinoPicker
              const Text('CupertinoPicker:'),
              SizedBox(
                height: 120,
                child: CupertinoPicker(
                  itemExtent: 36,
                  onSelectedItemChanged: (i) =>
                      setState(() => _pickerIndex = i),
                  children: _pickerItems
                      .map((item) => Center(child: Text(item)))
                      .toList(),
                ),
              ),
              Text('Dipilih: ${_pickerItems[_pickerIndex]}'),
              const SizedBox(height: 16),

              // Slide 15: CupertinoActivityIndicator
              const Row(
                children: [
                  CupertinoActivityIndicator(),
                  SizedBox(width: 12),
                  Text('CupertinoActivityIndicator'),
                ],
              ),
              const SizedBox(height: 16),

              // Info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Halaman ini menggunakan CupertinoPageScaffold & '
                  'CupertinoNavigationBar sebagai root iOS-style (Slide 15).\n\n'
                  'CupertinoApp digunakan sebagai root untuk full iOS theme, '
                  'namun di sini diintegrasikan dalam MaterialApp untuk kompatibilitas.',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Helper
// ─────────────────────────────────────────────────────────────
Widget _sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    ),
  );
}

// Transparent 1x1 pixel PNG bytes untuk FadeInImage placeholder
final Uint8List kTransparentImage = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00,
  0x0D, 0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
  0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89,
  0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x62,
  0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4,
  0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60,
  0x82,
]);
