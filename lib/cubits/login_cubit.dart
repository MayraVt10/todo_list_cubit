import 'package:bloc/bloc.dart';

class LoginCubit extends Cubit<bool> {
  LoginCubit() : super(false);

  void submit(String usuario, String password) {
    // Aquí agregarías la lógica de autenticación
    // En este ejemplo, simplemente emite un estado de autenticación exitosa
    emit(true);
  }
}
