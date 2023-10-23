abstract class IGenericRepository<T>{

  void create(T t);

  Future<T> read(String id);

  void update(T t);

  void delete(T t);
}

// ----------NOTE----------
//there are no interfaces in dart. However, I'm still labeling classes used as interfaces as INameOfTheClass