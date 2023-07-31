import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/reservation_repository.dart';
import '../domain/reservation.dart';

part 'reservation_service.g.dart';

class ReservationService {

  ReservationService({required this.reservationRepository});

  final ReservationRepository reservationRepository;

  Future<List<Reservation>> getReservationsByDate({required DateTime date}) {
    return reservationRepository.getReservationsByDate(date: date);
  }

  Future<Reservation> postReservation({required Reservation reservation}) {
    return reservationRepository.postReservation(reservation: reservation);
  }

  Future putReservation({required Reservation reservation}) {
    return reservationRepository.putReservation(reservation: reservation);
  }

  Future deleteReservation({required int id}) {
    return reservationRepository.deleteReservation(id: id);
  }
}
@riverpod
ReservationService reservationService(ReservationServiceRef ref) =>
    ReservationService(
        reservationRepository: ref.watch(reservationRepositoryProvider)
    );

@riverpod
Future<List<Reservation>> reservationsByDate(ReservationsByDateRef ref, {required DateTime date}) =>
    ref.watch(reservationServiceProvider).getReservationsByDate(date: date);

@riverpod
Future postReservation(PostReservationRef ref, {required Reservation reservation}) =>
    ref.watch(reservationServiceProvider).postReservation(reservation: reservation);

@riverpod
Future deleteReservation(DeleteReservationRef ref, {required int id}) =>
    ref.watch(reservationServiceProvider).deleteReservation(id: id);