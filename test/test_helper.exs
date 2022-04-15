Mox.defmock(ViacepClientMock, for: TecsolfacilServices.ViacepClient.Behaviour)
Application.put_env(:tecsolfacil, :switch_env, ViacepClientMock)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Tecsolfacil.Repo, :manual)
