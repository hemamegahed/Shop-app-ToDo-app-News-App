import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/layout/todo_app/cubit/cubit.dart';

import '../../modules/shop_app/login/cubit/states.dart';

Widget defaultButton({
  double wid = double.infinity,
  double r = 10.0,
  required String text,
  bool isUpper = true,
  Color back = Colors.blue,
  required final void Function() onPressed,
}) =>
    Container(
      width: wid,
      decoration: BoxDecoration(
        color: back,
        borderRadius: BorderRadius.circular(
          r,
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required final void Function() onPressed,
  required String text,
  bool isUpper = true,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        isUpper ? text.toUpperCase() : text,
      ),
    );

Container gender(
    {required Color background, required String pic, required String gender}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: background),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(pic),
          height: 90,
          width: 90,
        ),
        Text(
          gender,
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        )
      ],
    ),
  );
}

Widget defaultTextFormField(
        {required TextEditingController controller,
        bool ispassword = false,
        required Icon perfIcon,
        IconData? sufix,
        required TextInputType textType,
        Function? onSubmit,
        Function? onChange,
        Function? onTap,
        required FormFieldValidator<String> validator,
        required String labelText,
        bool? isClickable,
        Function? sufixPressed}) =>
    TextFormField(
      validator: validator,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged: (s) {
        onChange!(s);
      },
      controller: controller,
      obscureText: ispassword,
      keyboardType: textType,
      enabled: isClickable,
      decoration: InputDecoration(
          suffixIcon: sufix != null
              ? IconButton(
                  icon: Icon(sufix),
                  onPressed: () {
                    sufixPressed!();
                  },
                )
              : null,
          labelText: labelText,
          border: const OutlineInputBorder(),
          prefixIcon: perfIcon),
    );

Widget buildTaskItem(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            child: Text('${model['time']}'),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title']}',
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${model['date']}',
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: model['id']);
              },
              icon: const Icon(
                Icons.check_circle,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archive', id: model['id']);
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black54,
              )),
        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteData(id: model['id']);
    },
  );
}

Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () {
      // navigateTo(context, WebViewScreen(url: article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget myDivder() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey,
    ),
  );
}

Widget articleBuilder(list, context) {
  return ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => myDivder(),
          itemCount: list.length),
      fallback: (context) => const Center(child: CircularProgressIndicator()));
}

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);

Future<bool?> showToast({required String text, required ToastStates state}) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseToastColor(state),
      textColor: Colors.black,
      fontSize: 16.0);
}

enum ToastStates { ERROR, SUCCESS, WARNING }

Color? choseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
