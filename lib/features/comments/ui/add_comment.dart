import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:freetour_tfg/features/app/notifications/notifications.dart';
import 'package:freetour_tfg/features/app/ui/theme/extension.dart';
import 'package:freetour_tfg/features/models.dart';
import 'package:freetour_tfg/features/providers.dart';
import 'package:freetour_tfg/features/services.dart';
import 'package:freetour_tfg/features/widgets.dart';
import 'package:provider/provider.dart';

class AddCommentScreen extends StatelessWidget {
  const AddCommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddCommentsProvider>(context);
    final arg = ModalRoute.of(context)!.settings.arguments as Reservation;
    return Scaffold(
        appBar:
            AppBar(title: const Text('Agregar commentario'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: provider.addcomment,
            child: Column(
              children: [
                Row(
                  children: [
                    TextChip(
                        color: context.colors.surface,
                        style: context.titleSmall,
                        text: arg.title!),
                  ],
                ),
                const SizedBox(height: 15),
                RatingBar.builder(
                    initialRating: 0,
                    minRating: 0.5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                    itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (rating) => provider.rating = rating),
                const SizedBox(height: 15),
                TextFormField(
                  autocorrect: true,
                  cursorColor: context.colors.surface,
                  decoration: InputDecoration(
                      hintText: 'Titulo del comentario',
                      hintStyle: context.bodySmall),
                  style: context.bodyMedium,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => provider.title = value,
                  validator: (value) => provider.isvalidTitle(value!),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  autocorrect: true,
                  maxLines: 10,
                  cursorColor: context.colors.surface,
                  decoration: InputDecoration(
                      hintText: 'Que te pareció la guía',
                      hintStyle: context.bodySmall),
                  style: context.bodyMedium,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) => provider.comment = value,
                  validator: (value) => provider.isvalidComment(value!),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    child: const Text('Agregar comentario'),
                    onPressed: provider.isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            final service = Provider.of<CommentServices>(
                                context,
                                listen: false);
                            provider.isLoading = true;
                            if (provider.addcomment.currentState!.validate()) {
                              final Map<String, dynamic> data = {
                                "rating": provider.rating,
                                "title": provider.title,
                                "comment": provider.comment,
                                "userid": arg.userid,
                                "tourid": arg.tourid,
                                "tourimg": arg.imgurl,
                                "tourTitle": arg.title,
                                "reservationid": arg.idReservation
                              };
                              final String? resp = await service.addComment(
                                  data, arg.tourid!, arg.idReservation!);
                              if (resp == null) {
                                provider.isLoading = false;
                                Navigator.pushReplacementNamed(context, 'home');
                              } else {
                                provider.isLoading = false;
                                NotificationProvider.warningAlert(
                                    'Algo salió mal, intentelo más tarde');
                              }
                            }
                          })
              ],
            ),
          ),
        ));
  }
}
