import 'package:memories/_archive/app.dart';
import 'package:memories/main.dart';

class DashboardPage extends UI {
  const DashboardPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: () {
                    // memories(Memory());
                  },
                  child: const Icon(Icons.add_a_photo),
                  backgroundColor: Colors.teal,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   '${memories().length}',
                    //   style: const TextStyle(
                    //     fontSize: 64,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.teal,
                    //   ),
                    // ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
                      child: Text(
                        'Memories Count',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF9E9E9E),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => route(Routes.dashboard),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'View All Memories',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
