/// [Mapper] is an abstract class that defines the methods to convert a model to an entity and vice versa.
abstract class Mapper<M, E> {
  E toEntity(M model);

  M toModel(E entity);
}
