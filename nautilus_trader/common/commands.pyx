# -------------------------------------------------------------------------------------------------
#  Copyright (C) 2015-2020 Nautech Systems Pty Ltd. All rights reserved.
#  https://nautechsystems.io
#
#  Licensed under the GNU Lesser General Public License Version 3.0 (the "License");
#  You may not use this file except in compliance with the License.
#  You may obtain a copy of the License at https://www.gnu.org/licenses/lgpl-3.0.en.html
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# -------------------------------------------------------------------------------------------------

from cpython.datetime cimport datetime

from nautilus_trader.core.uuid cimport UUID
from nautilus_trader.model.identifiers cimport TraderId


cdef class Connect(Command):
    """
    Represents a command for a service to connect.
    """

    def __init__(
            self,
            Venue venue,  # Can be None
            UUID command_id not None,
            datetime command_timestamp not None,
    ):
        """
        Initialize a new instance of the Connect class.

        Parameters
        ----------
        venue : Venue
            The venue to connect to. If None then command is to connect to all
            venues.
        command_id : UUID
            The command identifier.
        command_timestamp : datetime
            The command timestamp.

        """
        super().__init__(command_id, command_timestamp)

        self.venue = venue

    def __str__(self) -> str:
        return f"{self.__class__.__name__}(venue={self.venue})"


cdef class Disconnect(Command):
    """
    Represents a command for a service to disconnect.
    """

    def __init__(
            self,
            Venue venue,  # Can be None
            UUID command_id not None,
            datetime command_timestamp not None,
    ):
        """
        Initialize a new instance of the Disconnect class.

        Parameters
        ----------
        venue : Venue
            The venue to disconnect from. If None then command is to disconnect
            from all venues.
        command_id : UUID
            The command identifier.
        command_timestamp : datetime
            The command timestamp.

        """
        super().__init__(command_id, command_timestamp)

        self.venue = venue

    def __str__(self) -> str:
        return f"{self.__class__.__name__}(venue={self.venue})"


cdef class DataCommand(Command):
    """
    The base class for all data commands.
    """

    def __init__(
            self,
            type data_type not None,
            dict options not None,
            UUID command_id not None,
            datetime command_timestamp not None,
    ):
        """
        Initialize a new instance of the DataCommand class.

        Parameters
        ----------
        data_type : type
            The data type for the command.
        options : dict
            The options for the command.
        command_id : UUID
            The command identifier.
        command_timestamp : datetime
            The command timestamp.

        """
        super().__init__(command_id, command_timestamp)

        self.data_type = data_type
        self.options = options

    def __str__(self) -> str:
        return (f"{self.__class__.__name__}("
                f"data_type={self.data_type}, "
                f"options={self.options}, "
                f"id={self.id}, "
                f"timestamp={self.timestamp})")


cdef class Subscribe(DataCommand):
    """
    Represents a command to subscribe to data.
    """

    def __init__(
            self,
            type data_type not None,
            dict options not None,
            UUID command_id not None,
            datetime command_timestamp not None,
    ):
        """
        Initialize a new instance of the Subscribe class.

        Parameters
        ----------
        data_type : type
            The data type for the command.
        options : dict
            The options for the command.
        command_id : UUID
            The command identifier.
        command_timestamp : datetime
            The command timestamp.

        """
        super().__init__(
            data_type,
            options,
            command_id,
            command_timestamp,
        )


cdef class Unsubscribe(DataCommand):
    """
    Represents a command to unsubscribe from data.
    """

    def __init__(
            self,
            type data_type not None,
            dict options not None,
            UUID command_id not None,
            datetime command_timestamp not None,
    ):
        """
        Initialize a new instance of the Unsubscribe class.

        Parameters
        ----------
        data_type : type
            The data type for the command.
        options : dict
            The options for the command.
        command_id : UUID
            The command identifier.
        command_timestamp : datetime
            The command timestamp.

        """
        super().__init__(
            data_type,
            options,
            command_id,
            command_timestamp,
        )


cdef class RequestData(DataCommand):
    """
    Represents a command to request data.
    """

    def __init__(
            self,
            type data_type not None,
            dict options not None,
            UUID command_id not None,
            datetime command_timestamp not None,
    ):
        """
        Initialize a new instance of the RequestData class.

        Parameters
        ----------
        data_type : type
            The data type for the command.
        options : dict
            The options for the command.
        command_id : UUID
            The command identifier.
        command_timestamp : datetime
            The command timestamp.

        """
        super().__init__(
            data_type,
            options,
            command_id,
            command_timestamp,
        )


cdef class KillSwitch(Command):
    """
    Represents a command to aggressively shutdown the trading system.
    """

    def __init__(
            self,
            TraderId trader_id not None,
            UUID command_id not None,
            datetime command_timestamp not None,
    ):
        """
        Initialize a new instance of the KillSwitch class.

        Parameters
        ----------
        trader_id : TraderId
            The trader identifier for the command.
        command_id : UUID
            The command identifier.
        command_timestamp : datetime
            The command timestamp.

        """
        super().__init__(command_id, command_timestamp)

        self.trader_id = trader_id

    def __str__(self) -> str:
        return f"{self.__class__.__name__}(trader_id={self.trader_id.value})"
