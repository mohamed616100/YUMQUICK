
import 'package:yumquick/features/MyOrders/data/models/Cancelleed_resopnse_model.dart';

abstract class CanceldState{}
 class CanceldInitial extends CanceldState{}
 class CanceldLoading extends CanceldState{}
 class CanceldSuccess extends CanceldState{
   final CanceldResopnse canceld;
   CanceldSuccess(this.canceld);
 }
 class CanceldError extends CanceldState {
   final String message;

   CanceldError(this.message);
 }