import factory
from sqlalchemy import orm

TestDBSession = orm.scoped_session(orm.sessionmaker())


class DBBaseModelFactory(factory.alchemy.SQLAlchemyModelFactory):
    class Meta:
        abstract = True
        sqlalchemy_session_persistence = "flush"
        sqlalchemy_session = TestDBSession
