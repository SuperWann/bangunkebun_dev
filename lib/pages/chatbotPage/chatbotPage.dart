import 'package:bangunkebun_dev/providers/chatbotProvider.dart';
import 'package:bangunkebun_dev/widgets/inputForm.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatbotPage extends StatefulWidget {
  static const routeName = '/chatbotPage';
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController pertanyaanController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatbotProvider chatbotProvider = ChatbotProvider();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatbotProvider>().getAllPercakapan();
    });
  }

  @override
  void dispose() {
    pertanyaanController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Function untuk scroll ke bawah setelah message baru
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Si Lumpo',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          actions: [
            // Tombol clear chat
            IconButton(
              icon: const Icon(Icons.delete_rounded, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Hapus Percakapan'),
                        content: const Text(
                          'Yakin ingin menghapus semua percakapan?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<ChatbotProvider>().clearChat();
                              Navigator.pop(context);
                            },
                            child: const Text('Hapus'),
                          ),
                        ],
                      ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<ChatbotProvider>(
                builder: (context, chatbotProvider, child) {
                  final messages = chatbotProvider.percakapan ?? [];

                  // Auto scroll ketika ada message baru
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (messages.isNotEmpty) {
                      _scrollToBottom();
                    }
                  });

                  if (messages.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Konsultasikan apa saja soal\nkebunmu di sini',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF007B29),
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isUser = message.senderType == 'user';

                      return Align(
                        alignment:
                            isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color:
                                isUser ? Colors.green[100] : Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16.0),
                              topRight: const Radius.circular(16.0),
                              bottomLeft:
                                  isUser
                                      ? const Radius.circular(16.0)
                                      : Radius.zero,
                              bottomRight:
                                  isUser
                                      ? Radius.zero
                                      : const Radius.circular(16.0),
                            ),
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          child: Column(
                            crossAxisAlignment:
                                isUser
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.pesan,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat(
                                  'HH:mm',
                                ).format(message.timestamp ?? DateTime.now()),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 10.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: SafeArea(
                child: Consumer<ChatbotProvider>(
                  builder: (context, chatbotProvider, child) {
                    return Row(
                      children: [
                        Expanded(
                          child: InputFormWithHintTextMaxlines(
                            type: TextInputType.text,
                            text: "Masukan pertanyaan",
                            controller: pertanyaanController,
                            // Disable input saat loading
                            // enabled: !chatbotProvider.isLoading,
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007B29),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(70, 50),
                            padding: EdgeInsets.zero,
                          ),
                          // Disable button saat loading
                          onPressed:
                              chatbotProvider.isLoading
                                  ? null
                                  : () {
                                    final text =
                                        pertanyaanController.text.trim();
                                    if (text.isNotEmpty) {
                                      chatbotProvider.sendPertanyaan(
                                        text,
                                        context,
                                      );
                                      pertanyaanController.clear();
                                    } else {
                                      Fluttertoast.showToast(
                                        fontAsset:
                                            'assets/fonts/Montserrat-Medium.ttf',
                                        msg: "Pertanyaan tidak boleh kosong",
                                      );
                                    }
                                  },
                          child:
                              chatbotProvider.isLoading
                                  ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                  : const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
