import Combine

class HabitInteractor {
    private var remote:HabitRemoteDataSource = .shared
    
}

extension HabitInteractor {
    func fetchHabits() -> Future<[HabitResponse],AppError> {
        return remote.fetchHabits()
    }
    
    
}
