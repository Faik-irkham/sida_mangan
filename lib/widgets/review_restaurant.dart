import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sida_mangan/data/model/add_review_model.dart';
import 'package:sida_mangan/provider/review_restaurant_provider.dart';

class ReviewRestaurantWidget extends StatefulWidget {
  final String id;
  const ReviewRestaurantWidget({super.key, required this.id});

  @override
  State<ReviewRestaurantWidget> createState() => _ReviewRestaurantWidgetState();
}

class _ReviewRestaurantWidgetState extends State<ReviewRestaurantWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  FocusNode reviewFocusNode = FocusNode();

  @override
  void dispose() {
    reviewFocusNode.dispose();
    super.dispose();
  }

  bool validate() {
    if (nameController.text.isEmpty && reviewController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                hintText: 'Name',
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              child: TextField(
                controller: reviewController,
                keyboardType: TextInputType.multiline,
                focusNode: reviewFocusNode,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  hintText: 'Review',
                ),
                style: const TextStyle(fontSize: 12),
                maxLines: 4,
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  if (validate()) {
                    Provider.of<ReviewProviders>(context, listen: false)
                        .apiService
                        .addReviews(
                          AddReviewModel(
                            id: widget.id,
                            name: nameController.text,
                            review: reviewController.text,
                          ),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Review submitted successfully.'),
                      ),
                    );
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Name cannot be empty.'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
