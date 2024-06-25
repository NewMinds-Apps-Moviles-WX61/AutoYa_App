import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  List<Contact> _contacts = [];

  late String ownerName;
  late String ownerPhotoURL;

  @override
  void initState() {
    super.initState();
    _loadOwnerData();
    _loadContacts();
  }

  Future<void> _loadOwnerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ownerName = prefs.getString('ownerName') ?? 'User1';
      ownerPhotoURL = prefs.getString('ownerPhotoURL') ??
          'https://i.postimg.cc/QMYLzms6/6326055.png';
    });
  }

  void _loadContacts() {
    // Simulando carga de contactos
    _contacts = [
      Contact(
          name: 'Alice',
          photoURL:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Alicia_Vikander_-_Tokyo_International_Film_Festival_2019_%2849013506278%29_%28cropped%29.jpg/1200px-Alicia_Vikander_-_Tokyo_International_Film_Festival_2019_%2849013506278%29_%28cropped%29.jpg'),
      Contact(name: 'Bob', photoURL: 'https://i.pravatar.cc/150?img=2'),
      Contact(name: 'Charlie', photoURL: 'https://i.pravatar.cc/150?img=3'),
      Contact(name: 'David', photoURL: 'https://i.pravatar.cc/150?img=4'),
      Contact(name: 'Emma', photoURL: 'https://i.pravatar.cc/150?img=5'),
      Contact(name: 'Frank', photoURL: 'https://i.pravatar.cc/150?img=6'),
      Contact(name: 'Grace', photoURL: 'https://i.pravatar.cc/150?img=7'),
      Contact(name: 'Hannah', photoURL: 'https://i.pravatar.cc/150?img=8'),
      Contact(name: 'Isaac', photoURL: 'https://i.pravatar.cc/150?img=9'),
      Contact(name: 'Jane', photoURL: 'https://i.pravatar.cc/150?img=10'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF03253C),
        title: Text(
          "Chats",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // Acción de búsqueda
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Acción de menú
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ListTile(
            onTap: () => _navigateToChat(contact),
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(contact.photoURL),
            ),
            title: Text(
              contact.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Mensaje reciente",
            ),
            trailing: Text(
              "10:30 PM",
              style: TextStyle(
                color: Color(0xFFF10303),
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToChat(Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(
          contact: contact,
          ownerName: ownerName,
          ownerPhotoURL: ownerPhotoURL,
        ),
      ),
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final Contact contact;
  final String ownerName;
  final String ownerPhotoURL;

  ChatDetailScreen({
    required this.contact,
    required this.ownerName,
    required this.ownerPhotoURL,
  });

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isUserTurn = true;

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      ownerName: _isUserTurn ? widget.ownerName : widget.contact.name,
      ownerPhotoURL:
          _isUserTurn ? widget.ownerPhotoURL : widget.contact.photoURL,
      isOwner: _isUserTurn,
    );
    setState(() {
      _messages.insert(0, message);
      _isUserTurn = !_isUserTurn;
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                hintText: "Enviar un mensaje",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15.0,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF03253C),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFF10303),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.contact.photoURL),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.contact.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "En línea",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call, color: Colors.white),
            onPressed: () {
              // Acción de videollamada
            },
          ),
          IconButton(
            icon: Icon(Icons.call, color: Colors.white),
            onPressed: () {
              // Acción de llamada
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Menú de opciones del chat
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String ownerName;
  final String ownerPhotoURL;
  final bool isOwner;

  ChatMessage({
    required this.text,
    required this.ownerName,
    required this.ownerPhotoURL,
    required this.isOwner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isOwner ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isOwner)
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                child: ClipOval(
                  child: Image.network(
                    ownerPhotoURL,
                    height: 35,
                    width: 35,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isOwner ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  ownerName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isOwner ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      topLeft: Radius.circular(isOwner ? 0 : 20.0),
                    ),
                  ),
                  child: Text(
                    text,
                    style:
                        TextStyle(color: isOwner ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Contact {
  final String name;
  final String photoURL;

  Contact({required this.name, required this.photoURL});
}
